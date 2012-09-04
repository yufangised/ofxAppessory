/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * LightSensor.h
 *
 * Created by Wang Yufan on 8/17/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofEvents.h"
#import  "ARDUINO_DEFINE.h"
#import  "DigitalOut.h"
#import  "LED.h"
//#import "iViewController.h"
#import "iTextField.h"

class iTextField;

class LightSensor
{
public:     
    LightSensor              (DIGITAL_PIN digitalPin);
    LightSensor              (DIGITAL_PIN digitalPin, TRIGGER_AT state); 
                              
    LightSensor              (ANALOG_PIN analogPin);
    LightSensor              (ANALOG_PIN analogPin, TRIGGER_WHEN direction, int threshold);
    ~LightSensor             ();
    
    void                     reverse();
    
    bool                     getState();
	int                      getValue();
    
    void                     attach(bool &variable);
    void                     attach(int &variable, int rangeMinimum, int rangeMaximum);
    void                     attach(float &variable, float rangeMinimum, float rangeMaximum);
    void                     attach(iTextField *textField);
        
    int                      pinNumber;
    
    
    bool                     isAnalog;
    
    ofEvent<int>             triggeredOn;
    ofEvent<int>             triggeredOff;
    
private:
    int                      analogThreshold;
    bool                     triggerState;
    
    bool                     isReverse;
    
    int                      currentValue;    
    int                      tempValue;
    int                      currentState;    
    int                      tempState;
    
    void                     update(ofEventArgs & args);
};
