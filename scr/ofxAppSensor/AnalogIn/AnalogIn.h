/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * AnalogIn.h
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofxiPhoneExtras.h"
#include "ofEvents.h"

#import "ARDUINO_DEFINE.h"
#import "iViewController.h"
#import "Label.h"
#import "iTextField.h"


class iTextField;

class iViewController;

class AnalogIn
{
public:
    AnalogIn            (ANALOG_PIN analogPin);
    AnalogIn            (ANALOG_PIN analogPin , float x, float y);
    AnalogIn            (ANALOG_PIN analogPin, float x, float y, string labelName);
    ~AnalogIn           ();
    
    int                 analogRead();
    
    void                setLabelTextColor(int r, int g, int b, int a);
    void                setLabelBackgroundColor(int r, int g, int b, int a);
    
    void                addToView(iViewController *iView);
    
    void                attach(int &varible);
    void                attach(float &varible);
    void                attach(iTextField *textField);
    
    int                 pinNumber;
    
private:
    Label               *label;
    UITextField         *analogInput;
    UIColor             *textColorOfLabel;
    UIColor             *backgroundColorOfLabel;
    NSString            *labelNameString;
    
    CGRect              labelFrame;
    CGRect              inputBoxFrame;
    
    float               xPosition;
    float               yPosition;
    float               labelOffset;
    float               labelWidth;
    
    
    int                 labelLength;
    
    bool                withUI;
    bool                withLabel;
    
    void                update(ofEventArgs & args);

};
