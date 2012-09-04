/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iTextField.h
 *
 * Created by Wang Yufan on 8/20/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofEvents.h"
#include "ofxiPhoneExtras.h"
#import  "iViewController.h"
#import  "ocTextField.h"
#import  "iSlider.h"
#import  "Potentiometer.h"
#import  "LightSensor.h"

class AnalogIn;
class Potentiometer;
class LightSensor;


class iTextField
{
public:
    iTextField      ();
    iTextField      (string text);
    ~iTextField     ();
    
    void            setFrame(float x, float y, float width, float height);
    void            setTextFieldStyle(TEXT_FIELD_STYLE style);
    
    
    
    void            setBackground(int r, int g, int b, int a);
    void            setBackground(PREDEFINED_BACKGROUND background);
    void            setTextColor(int r, int g, int b, int a);
    
    void            setFont(float fontSize);
    void            setFont(float fontSize, FONT_STYLE style);
    void            setFont(float fontSize, FONT_STYLE, bool withShadow);
    
    void            setTextAlignment(TEXT_ALIGNMENT alignment);
    
    void            addToView(iViewController *iView);
    void            setText(string text);
    
    //void            attachTo(
    string          getText();
    
    void            attactTo(int variable);
    void            attachTo(float variable);
    void            attactTo(bool variable);
    void            attachTo(string variable);
    void            attactTo(AnalogIn *analogIn);
    void            attachTo(iSlider *slider);
    void            attachTo(Potentiometer *potentiometer);
    void            attachTo(LightSensor *lightSensor);
    
private:
    UIColor        *colorOftext;
    UIColor        *colorOfBackground;
     
    CGRect         textFieldFrame;
    ocTextField    *textField; 
    string         textOfTextField;
    bool           isLayout;
    float          sizeOfFont;
    int            styleOfFont;
    int            alignmentOfText;
    int            styleOfTextField;
    
};
