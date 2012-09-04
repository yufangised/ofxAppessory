/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * AnalogIn.mm
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include <iostream>
#include "AnalogIn.h"



AnalogIn::AnalogIn(ANALOG_PIN analogPin){
    
    pinNumber = analogPin;
    ANALOG_CONFIG_BUF[pinNumber] = 'a';
    
    withUI = false;
    withLabel = false;
    
}

AnalogIn::AnalogIn(ANALOG_PIN analogPin, float x, float y){
    
    pinNumber = analogPin;
    ANALOG_CONFIG_BUF[pinNumber] = 'a';
    
    withUI = true;
    withLabel = false;
    
    xPosition = x;
    yPosition = y;
    labelOffset = 0;
    labelLength = 0;
    labelWidth = 0;
    
    inputBoxFrame = CGRectMake(xPosition, yPosition, 55.0f, 27.0f);
    
    ofAddListener(ofEvents().update, this, &AnalogIn::update);
}

AnalogIn::AnalogIn(ANALOG_PIN analogPin, float x, float y, string labelName){
    
    pinNumber = analogPin;
    ANALOG_CONFIG_BUF[pinNumber] = 'a';
    withUI = true;
    withLabel = true;
    
    xPosition = x;
    yPosition = y;
    
    if(labelName == DEFAULT){
        if (pinNumber < 10) {
            labelLength = 2;
        } else {
            labelLength = 3;
        }
        
        stringstream labelString;
        labelString << "A" << pinNumber;
        labelNameString = ofxStringToNSString(labelString.str());
    }else {
        labelLength = labelName.length();
        labelNameString = ofxStringToNSString(labelName);
    }

    labelWidth = labelLength * 10 + 5.0f;
    labelOffset = 3.0f;
    
    labelFrame = CGRectMake(xPosition, yPosition + 1.0f, labelWidth, 25.0f);
    
    inputBoxFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, 55.0f, 27.0f); 
    
    textColorOfLabel = [UIColor whiteColor];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
        
    ofAddListener(ofEvents().update, this, &AnalogIn::update);
}



AnalogIn::~AnalogIn(){
    
    [label dealloc];
    [analogInput release];
    [labelNameString release];
    [backgroundColorOfLabel release];
    [textColorOfLabel release];

}
    
void AnalogIn::setLabelTextColor(int r, int g, int b, int a){
    if (withLabel) {
        textColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                           green:ofClamp(g, 0, 255)/255.0f 
                                            blue:ofClamp(b, 0, 255)/255.0f 
                                           alpha:ofClamp(a, 0, 255)/255.0f];
    }
    
    
}

void AnalogIn::setLabelBackgroundColor(int r, int g, int b, int a){
    if (withLabel) {
        backgroundColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                                 green:ofClamp(g, 0, 255)/255.0f 
                                                  blue:ofClamp(b, 0, 255)/255.0f 
                                                 alpha:ofClamp(a, 0, 255)/255.0f];
    }
}

int AnalogIn::analogRead()
{   
    
    return ANALOG_INPUT[pinNumber];
    
}

void AnalogIn::attach(int &varible){

    varible = ANALOG_INPUT[pinNumber];
}

void AnalogIn::attach(float &varible){
    
    varible = ANALOG_INPUT[pinNumber];
}

void AnalogIn::attach(iTextField *textField){
    
    stringstream valueSting;
    valueSting << ANALOG_INPUT[pinNumber];
    textField->setText(valueSting.str());
}

void AnalogIn::addToView(iViewController *iView){
    if (withUI) {
        if (withLabel) {
            
            label = [[Label alloc] initWithFrame:labelFrame
                                            name:labelNameString
                                      labelColor:backgroundColorOfLabel
                                       textColor:textColorOfLabel];
            
            [iView->myView.view addSubview:label];
            
        }
            
        analogInput = [[UITextField alloc] initWithFrame:inputBoxFrame];
        analogInput.borderStyle = UITextBorderStyleRoundedRect;
        analogInput.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [analogInput setUserInteractionEnabled:NO];
            
        stringstream valueString;
        valueString << ANALOG_INPUT[pinNumber];
        analogInput.text = ofxStringToNSString(valueString.str());
            
        [iView->myView.view addSubview:analogInput];
        
        
    }else {
        ofLog()<<"Warning: AnalogIn Pin" << pinNumber << " was initialized without UI element!";

    }
    
}

void AnalogIn::update(ofEventArgs &Args){
    
    stringstream ss;
    ss << ANALOG_INPUT[pinNumber];
    analogInput.text = ofxStringToNSString(ss.str());
    
}
