/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * Potentiometer.h
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofMath.h"
#include "ofEvents.h"
#import  "ARDUINO_DEFINE.h"
#import "iTextField.h"


class iTextField;


class Potentiometer
{
public:     
    
    Potentiometer            (ANALOG_PIN analogPin);
    Potentiometer            (ANALOG_PIN analogPin, TRIGGER_WHEN direction, int threshold);
    ~Potentiometer           ();
    
    void                     reverse();

	int                      getValue();
    
    void                     attach(int &variable, int rangeMinimum, int rangeMaximum);
    void                     attach(float &variable, float rangeMinimum, float rangeMaximum);
    void                     attach(iTextField *textField);
    
    int                      pinNumber;
    
    
    
    ofEvent<int>             triggeredOn;
    ofEvent<int>             triggeredOff;
    
private:
    int                      analogThreshold;
    bool                     triggerState;
    bool                     isReverse;
    
    int                      currentValue;    
    int                      tempValue;
    
    void                     update(ofEventArgs & args);
};
