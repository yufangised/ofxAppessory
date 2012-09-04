/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * DigitalIn.h
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofEvents.h"
#include "ofxiPhoneExtras.h"
#import  "ARDUINO_DEFINE.h"
#import  "iViewController.h"
#import  "LEDUI.h"
#import  "Label.h"
#import "iTextField.h"

class iTextField;

class DigitalIn
{
public:
    DigitalIn           (DIGITAL_PIN digitalPin);
    DigitalIn           (DIGITAL_PIN digitalPin, float x, float y);
    DigitalIn           (DIGITAL_PIN digitalPin, float x, float y, string labelName);
    ~DigitalIn          ();
    
    STATE               digitalRead();
    
    void                setLabelTextColor(int r, int g, int b, int a);
    void                setLabelBackgroundColor(int r, int g, int b, int a);
    
    void                addToView(iViewController *iView);
    
    void                attach(bool &variable);
    void                attach(iTextField *textField);
    
    int                 pinNumber;
    
private:
    
    LEDUI               *led;
    Label               *label;
    NSString            *labelNameString;
    UIColor             *textColorOfLabel;
    UIColor             *backgroundColorOfLabel;
    
    CGRect              labelFrame;
    CGRect              ledFrame;
    
    float               xPosition;
    float               yPosition;
    float               labelWidth;
    float               labelOffset;
    
    bool                withUI;
    bool                withLabel;
    
    
    int                 ledColor;
    int                 labelLength;
    int                 tempState;
    
    void                update(ofEventArgs & args);
};
