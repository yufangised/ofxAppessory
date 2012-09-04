/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ofxAppSensor.mm - ofxAppSensor library
 * Copyright (c) 2012 Copenhagen Institute of Interaction Design. 
 * All right reserved.
 *
 * This library is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser Public License for more details.
 *
 * You should have received a copy of the GNU Lesser Public License
 * along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
 *
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * + author: yufan + dviid
 * + contact: w.yufan@edu.ciid.dk + dviid@labs.ciid.dk
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include "ofxAppSensor.h"


ofxAppSensor::ofxAppSensor(ofxSerial &serialPort){

    serial = &serialPort;
    configed = false;
    sendAgain = true;
    incomingByte = '0';

}

ofxAppSensor::~ofxAppSensor(){


}

void ofxAppSensor::update(){
    
    if(configed == false){
        configration();
    }else {
        receiving();
        sending();
    }
}



void ofxAppSensor::configration(){
    
    if (sendAgain == true) {
        serial->writeByte('[');
        serial->writeBytes(DIGITAL_CONFIG_BUF, sizeof(DIGITAL_CONFIG_BUF));
        serial->writeBytes(ANALOG_CONFIG_BUF,sizeof(ANALOG_CONFIG_BUF));
        serial->writeByte(']');
        sendAgain = false;
    }
    
    
    if (serial->available()) {
        incomingByte = serial->readByte();
        if (incomingByte == '>') {
            sendAgain = false;
            configed = true;
        }
        if(incomingByte == '<'){
            sendAgain = true;
            configed = false;
        }
    }
}


void ofxAppSensor::receiving(){
    
    if(serial->available() >0){
        incomingByte = serial->readByte();
        if (incomingByte == '\0') {
            numberOfBytes = serial->readByte();
            memset(rxBuffer, 0, sizeof(rxBuffer));//clear the rxBuffer
            serial->readBytes(rxBuffer, numberOfBytes);
            
            //update digital_pwm
            bitset<8> digitalLower = bitset<8>(rxBuffer[0]);
            bitset<8> digitalHigher = bitset<8>(rxBuffer[1]);
            
            for (int n = 2; n < sizeof(DIGITAL_CONFIG_BUF); n++) {
                if (DIGITAL_CONFIG_BUF[n] == 'd'){
                    if (n<8) {
                        digitalLower[n-2] ? DIGITAL_PWM[n]= 1 : DIGITAL_PWM[n] = 0;
                    }else {
                        digitalHigher[n-8] ? DIGITAL_PWM[n]= 1 : DIGITAL_PWM[n] = 0;
                    }
                }
            }
            
            //update analog data
            if(numberOfBytes > 2){
                for (int i = 2; i < numberOfBytes; i++) {
                    
                    receivedByte = rxBuffer[i];
                    
                    bool      byteFlag = (bitset<8>(receivedByte)).test(7);
                    bitset<8> pinIndexBit = (bitset<8>(receivedByte) & bitset<8>(127)) >> 2;
                    unsigned int pinIndex = pinIndexBit.to_ulong() - 14;
                    
                    unsigned int lowerValue = (bitset<8>(receivedByte) & bitset<8>(3)).to_ulong();
                    unsigned int highterValue = 0;
                    
                    if(ANALOG_CONFIG_BUF[pinIndex] == 'a'){
                        //analogInput
                        if (byteFlag == true) {
                            i++;
                            receivedByte = rxBuffer[i];
                            highterValue = int(receivedByte) * 4;
                        }
                        ANALOG_INPUT[pinIndex] = lowerValue + highterValue;
                    }
                }
            }
            
        }else {
            // while (readByte() < 0);
        }    
    }
}


void ofxAppSensor::sending(){
    
    NUM_OF_SENDING_BYTES = 4;
    memset(txBuffer, 0, sizeof(txBuffer));//clear the txBuffer
    
    bitset<8> digitalLower = bitset<8>(192);// 1100 0000
    bitset<8> digitalHigher = bitset<8>(192);
    
    for (int i = 2; i < sizeof(DIGITAL_CONFIG_BUF); i++) {
        
        if(DIGITAL_CONFIG_BUF[i] == 'D'){//digital output 
            if (i<8) {
                DIGITAL_PWM[i] ? digitalLower.set(i-2):digitalLower.reset(i-2);
            }else {
                DIGITAL_PWM[i] ? digitalHigher.set(i-8):digitalHigher.reset(i-8);
            }
            
        }
        
        if(DIGITAL_CONFIG_BUF[i] == 'A'){
            if (DIGITAL_PWM[i] <= 3) {
                txBuffer[NUM_OF_SENDING_BYTES++] = pwmFormatter_PIN(i, DIGITAL_PWM[i]);
            }else {
                txBuffer[NUM_OF_SENDING_BYTES++] = pwmFormatter_PIN(i, DIGITAL_PWM[i]);
                txBuffer[NUM_OF_SENDING_BYTES++] = pwmFormatter_VALUE(DIGITAL_PWM[i]);
                
            }
        }
    }
    
    if (NUM_OF_SENDING_BYTES >= 4) {
        txBuffer[0] = '\0';
        txBuffer[1] = NUM_OF_SENDING_BYTES-2; //do not count the first 2 byte '\0' and numberOfBytes;
        txBuffer[2] = digitalLower.to_ulong();
        txBuffer[3] = digitalHigher.to_ulong();
        
        serial->writeBytes(txBuffer, NUM_OF_SENDING_BYTES);
    }
}


unsigned char ofxAppSensor::pwmFormatter_PIN(int pinNumber,  unsigned int pwm){
    
    unsigned char result;
    
    bitset<8> pin = bitset<8>(pinNumber)<<2;
    bitset<8> pwmValue = bitset<8>(pwm) & bitset<8>(3);
    if (pwm > 3) pin.set(7);
    result = (pin | pwmValue).to_ulong();
    
    return result;
}


unsigned char ofxAppSensor::pwmFormatter_VALUE(unsigned int pwm){
    
    unsigned char result;
    bitset<8> pwmValue = bitset<8>(pwm)>>2;
    result = pwmValue.to_ulong();
    return result;
}