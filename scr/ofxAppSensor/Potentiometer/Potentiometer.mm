/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * Potentiometer.mm
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include <iostream>
#include "Potentiometer.h"



Potentiometer::Potentiometer(ANALOG_PIN analogPin){
    
    pinNumber = analogPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'a';
    isReverse = false;
    
    currentValue = ANALOG_INPUT[pinNumber];
    tempValue = currentValue;
    
}

Potentiometer::Potentiometer(ANALOG_PIN analogPin, TRIGGER_WHEN direction, int threshold){
    
    pinNumber = analogPin;
    ANALOG_CONFIG_BUF[pinNumber] = 'a';
    isReverse = false;
    
    analogThreshold = threshold;
    
    currentValue = ANALOG_INPUT[pinNumber];
    tempValue = currentValue;
    
    triggerState = direction;   
    ofAddListener(ofEvents().update, this, &Potentiometer::update);
    
}

void Potentiometer::reverse(){
    isReverse = true;
}


int Potentiometer::getValue(){
    
   if (isReverse) {
       return 1023 - ANALOG_INPUT[pinNumber];
   } else {
       return ANALOG_INPUT[pinNumber];
   }
}

void Potentiometer::attach(int &variable, int rangeMinimum, int rangeMaximum){
    
    int inputValue;
    if (isReverse) {
        inputValue = 1023 - ANALOG_INPUT[pinNumber];
    } else {
        inputValue = ANALOG_INPUT[pinNumber];
    }
    
    if (rangeMaximum > rangeMinimum) {
        variable = (int) (ofMap(inputValue, 0, 1023, rangeMinimum, rangeMaximum));
    } else {
        variable = (int) (ofMap(inputValue, 0, 1023, rangeMaximum, rangeMinimum));
            ofLog() << "Warning: Potentiometer method: attach(int &variable, int rangeMinimum, int rangeMaximum) value range was set wrong!";
        }
        
}


void Potentiometer::attach(float &variable, float rangeMinimum, float rangeMaximum){
    
    int inputValue;
    if (isReverse) {
        inputValue = 1023 - ANALOG_INPUT[pinNumber];
    } else {
        inputValue = ANALOG_INPUT[pinNumber];
    }

        
    if (rangeMaximum > rangeMinimum) {
        variable =  (ofMap(inputValue, 0, 1023, rangeMinimum, rangeMaximum));
    } else {
        variable =  (ofMap(inputValue, 0, 1023, rangeMaximum, rangeMinimum));
        ofLog() << "Warning: Potentiometer method: attach(float &variable, float rangeMinimum, float rangeMaximum) value range was set wrong!";
    }
}

void Potentiometer::attach(iTextField *textField){
    
    int inputValue;
    if (isReverse) {
        inputValue = 1023 - ANALOG_INPUT[pinNumber];
    } else {
        inputValue = ANALOG_INPUT[pinNumber];
    }
    
   
    stringstream valueString; 
    valueString << inputValue;
    textField->setText(valueString.str());
}


void Potentiometer::update(ofEventArgs &Args){
    
    if (isReverse) {
        tempValue = 1023 - ANALOG_INPUT[pinNumber];
    }else {
        tempValue = ANALOG_INPUT[pinNumber];
    }
        
        
    if (triggerState == LARGER_THAN) {
            
        if (tempValue > analogThreshold || currentValue <= analogThreshold) {
            currentValue = tempValue;
            ofNotifyEvent(triggeredOn, currentValue, this);
        }
            
        if (tempValue < analogThreshold || currentValue >= analogThreshold) {
            currentValue = tempValue;
            ofNotifyEvent(triggeredOff, currentValue, this);
        }
    }
        
        
    if (triggerState == SMALLER_THAN) {
            
        if (tempValue < analogThreshold || currentValue >= analogThreshold) {
            currentValue = tempValue;
            ofNotifyEvent(triggeredOn, currentValue, this);
        }
            
        if (tempValue > analogThreshold || currentValue <= analogThreshold) {
            currentValue = tempValue;
            ofNotifyEvent(triggeredOff, currentValue, this);
        }
    }
}


