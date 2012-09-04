/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * DigitalOut.h
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
#import  "DigitalOutSwitch.h"
#import  "Label.h"
#import  "iSwitch.h"
#import  "DigitalIn.h"


class iSwitch;
class DigitalIn;

class DigitalOut
{
public:
    DigitalOut          (DIGITAL_PIN digitalPin);
    DigitalOut          (DIGITAL_PIN digitalPin, float x, float y);
    DigitalOut          (DIGITAL_PIN digitalPin, float x, float y, string labelName);
    
    ~DigitalOut         ();
    
    void                digitalWrite(STATE state);
    
    void                setSwitchOnColor(int r, int g, int b, int a);
    
    void                setLabelTextColor(int r, int g, int b, int a);
    void                setLabelBackgroundColor(int r, int g, int b, int a);

    void                addToView(iViewController *iView);
    
    void                attachTo(bool variable);
    void                attachTo(iSwitch *aSwitch);
    void                attachTo(DigitalIn *digitalIn);
    
    int                 pinNumber;
    
private:
    DigitalOutSwitch    *digitalSwitch;
    Label               *label;
    UIColor             *textColorOfLabel;
    UIColor             *backgroundColorOfLabel;
    UIColor             *stateColorOfSwitch;
    NSString            *labelNameString;
    
    CGRect              labelFrame;
    CGRect              switchFrame;
    
    
    int                 labelLength;
    float               xPosition;
    float               yPosition;
    float               labelOffset;
    float               labelWidth;
    
    bool                withUI;
    bool                withLabel;
    
};
