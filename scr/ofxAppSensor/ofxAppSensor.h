/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ofxAppSensor.h - ofxAppSensor library
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

#define BUFFER_LEN 32

#include <termios.h>
#include <iostream>
#include <bitset>
#include "ofConstants.h"
#include "ofTypes.h"

#import  "ARDUINO_DEFINE.h"
#import  "ofxSerial.h"

// ARDUINO INPUT/OUTPUT
#import  "AnalogIn.h"
#import  "DigitalIn.h"
#import  "DigitalOut.h"
#import  "PWM.h"

// SENSORS 
#import  "Button.h"
#import  "LED.h"
#import  "LightSensor.h"
#import  "Potentiometer.h"

class ofxAppSensor
{
public:
    ofxAppSensor        (ofxSerial &serialPort);
    ~ofxAppSensor       ();
    
    void                update();
    
    
private:
    ofxSerial           *serial;
    
    bool                configed;
    bool                sendAgain;
    
    unsigned char       receivedByte;
    unsigned char       numberOfBytes;
    unsigned char       incomingByte;
    unsigned char       txBuffer[BUFFER_LEN];
    unsigned char       rxBuffer[BUFFER_LEN];
    
    void                configration();
    void                sending();
    void                receiving();
    unsigned char       pwmFormatter_PIN(int pinNumber, unsigned int pwm);
    unsigned char       pwmFormatter_VALUE(unsigned int pwm);
    
};
