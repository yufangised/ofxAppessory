/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * PWM.h
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofxiPhoneExtras.h"
#include "ofEvents.h"
#import  "ARDUINO_DEFINE.h"
#import  "iViewController.h"
#import  "PWMSlider.h"
#import  "iSlider.h"
#import  "Label.h"

class iSlider;


class PWM
{
public:
    PWM                 (PWM_PIN pwmPin);
    PWM                 (PWM_PIN pwmPin, float x, float y, float length);
    PWM                 (PWM_PIN pwmPin, float x, float y, float length, string labelName);
    ~PWM                ();
    
    void                analogWrite(int analogValue);
    
    void                setLabelTextColor(int r, int g, int b, int a);
    void                setLabelBackgroundColor(int r, int g, int b, int a);
    
    void                addToView(iViewController *iView);
    
    void                attachTo(iSlider *slider);
    void                attactTo(float variable);
    void                attachTo(int variable);
    
    int                 pinNumber;
    
private:
    
    PWMSlider           *pwmSlider;
    Label               *label;
    UIColor             *textColorOfLabel;
    UIColor             *backgroundColorOfLabel;
    NSString            *labelNameString;
    
    CGRect              labelFrame;
    CGRect              sliderFrame;
    
    
    int                 labelLength;
    
    float               xPosition;
    float               yPosition;
    float               sliderLength;
    float               labelOffset;
    float               labelWidth;
    
    bool                withUI;
    bool                withLabel;
    
public:
    
};
