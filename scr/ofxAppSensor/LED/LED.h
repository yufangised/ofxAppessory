/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * LED.h
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofxiPhoneExtras.h"
#include "ofEvents.h"
#include <iostream>

#import "ARDUINO_DEFINE.h"
#import "DigitalIn.h"
#import "LEDUI.h"
#import "Label.h"
#import "iViewController.h"
#import "iSwitch.h"



typedef enum LED_SIZE
{
    LED_3MM = 20,
    LED_5MM = 27
    
} LED_SIZE;

typedef enum LED_COLOR
{
    GREEN = 0,
    RED = 1,
    BLUE = 2,
    YELLOW = 3
    
} LED_COLOR;

class DigitalIn;

class LED
{
public:
    LED                 (DIGITAL_PIN digitalPin);
    LED                 (DIGITAL_PIN digitalPin, float x, float y);
    LED                 (DIGITAL_PIN digitalPin, float x, float y, string labelName);
    LED                 (DIGITAL_PIN digitalPin, float x, float y, LED_COLOR color, LED_SIZE size);
    LED                 (DIGITAL_PIN digitalPin, float x, float y, LED_COLOR color, LED_SIZE size,  string labelName);
    
    LED                 (PWM_PIN pwmPin);
    LED                 (PWM_PIN pwmPin, float x, float y);
    LED                 (PWM_PIN pwmPin, float x, float y, string labelName);
    LED                 (PWM_PIN pwmPin, float x, float y, LED_COLOR color, LED_SIZE size);
    LED                 (PWM_PIN pwmPin, float x, float y, LED_COLOR color, LED_SIZE size,  string labelName);
    
    ~LED                ();
    
    void                setOn();
    void                setOff();
    
    void                setBrightness(int pwmValue);                                      
    void                setLabelTextColor(int r, int g, int b, int a);
    void                setLabelBackgroundColor(int r, int g, int b, int a);
    
    void                addToView(iViewController *iView);
    
    void                attachTo(bool variable);
    void                attachTo(int variable, int rangeMinimum, int rangeMaximum);
    void                attachTo(float variable, float rangeMinimum, float rangeMaximum);
    void                attachTo(iSwitch *aSwitch);//
    void                attachTo(DigitalIn *digitalIn);//
    
    int                 pinNumber;
    bool                isPWM;
    
private:
    UIColor             *textColorOfLabel;
    UIColor             *backgroundColorOfLabel;
    LEDUI               *led;
    Label               *label;
    NSString            *labelNameString;
    CGRect              labelFrame;
    CGRect              ledFrame;
    
    STATE               state;
    
    float               labelWidth;
    float               labelOffset;
    float               xPosition;
    float               yPosition;
    
    
    bool                withLabel;
    bool                withUI;
    
    int                 ledColor;
    int                 labelLength;
    int                 tempState;
    int                 tempValue;
    int                 currentValue;
    void                update(ofEventArgs & args);

};
