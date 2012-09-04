/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iSlider.h
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#import  "ocSlider.h"
#include "ofEvents.h"
#import  "iViewController.h"
#import  "iTextField.h"
#import  "ARDUINO_DEFINE.h"
#import  "PWM.h"
#import  "LED.h"

class PWM;
class LED;
class iTextField;

class iSlider
{
public:
    iSlider         (float x, float y, float length);
    ~iSlider        ();

    
    void            setValueRange(float min, float max);
    void            customizeWithImage(string imageName);
    float           getValue();
    
    void            addToView(iViewController *iView);
    
    void            attach(float &variable);
    void            attach(float &variable, float RangeMinimum, float rangeMaximum);
    void            attach(PWM *pwm);
    void            attach(LED *led);
    void            attach(iTextField *textField);
    
    float           minValue;
    float           maxValue;
    ofEvent<float>  valueChanged;
	
private:
    ocSlider        *slider; 
    
    //void            update(ofEventArgs & args);
};
