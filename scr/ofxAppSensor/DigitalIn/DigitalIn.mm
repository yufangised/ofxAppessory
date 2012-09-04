/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * DigitalIn.mm
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include <iostream>
#include "DigitalIn.h"




DigitalIn::DigitalIn(DIGITAL_PIN digitalPin){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'd'; 
    withUI = false;
    withLabel = false;
    
    tempState = DIGITAL_PWM[pinNumber];
    ofAddListener(ofEvents().update, this, &DigitalIn::update);
}

DigitalIn::DigitalIn(DIGITAL_PIN digitalPin, float x, float y){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'd'; 
    xPosition = x;
    yPosition = y;
    withUI = true;
    withLabel = false;
    labelLength = 0;
    labelOffset = 0;
    
    ledColor = 0;//GREEN 5MM is default
    ledFrame = CGRectMake(xPosition, yPosition, 27.0f, 27.0f);
    
    tempState = DIGITAL_PWM[pinNumber];
    ofAddListener(ofEvents().update, this, &DigitalIn::update);

}
DigitalIn::DigitalIn(DIGITAL_PIN digitalPin, float x, float y, string labelName){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'd'; 
    xPosition = x;
    yPosition = y;
    withUI = true;
    withLabel = true;
    
    if(labelName == DEFAULT){
        if (pinNumber < 10) {
            labelLength = 2;
        } else {
            labelLength = 3;
        }
        stringstream labelString;
        labelString << "D" << pinNumber;
        labelNameString = ofxStringToNSString(labelString.str());
    }else {
        labelLength = labelName.length();
        labelNameString = ofxStringToNSString(labelName);
    }
    
    labelWidth = labelLength * 10 + 5.0f;
    labelOffset = 3.0f;
    labelFrame = CGRectMake(xPosition, yPosition + 1.0f, labelWidth, 25.0f);
    
    textColorOfLabel = [UIColor whiteColor];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
    ledColor = 0;
    ledFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, 27.0f, 27.0f);
    
    tempState = DIGITAL_PWM[pinNumber];
    
    ofAddListener(ofEvents().update, this, &DigitalIn::update);
    
}


DigitalIn::~DigitalIn(){
    
    [led release];
    [label release];
    [labelNameString release];
    [textColorOfLabel release];
    [backgroundColorOfLabel release];
    
}
    
void DigitalIn::setLabelTextColor(int r, int g, int b, int a){
    if (withLabel) {
        textColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                           green:ofClamp(g, 0, 255)/255.0f 
                                            blue:ofClamp(b, 0, 255)/255.0f 
                                           alpha:ofClamp(a, 0, 255)/255.0f];
    }
    
    
}

void DigitalIn::setLabelBackgroundColor(int r, int g, int b, int a){
    if (withLabel) {
        backgroundColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                                 green:ofClamp(g, 0, 255)/255.0f 
                                                  blue:ofClamp(b, 0, 255)/255.0f 
                                                 alpha:ofClamp(a, 0, 255)/255.0f];
    }
}

void DigitalIn::addToView(iViewController *iView){
    
    if (withUI) {
        if (withLabel) {
            
            label = [[Label alloc] initWithFrame:labelFrame 
                                            name:labelNameString 
                                      labelColor:backgroundColorOfLabel 
                                       textColor:textColorOfLabel];
            
            
            [iView->myView.view addSubview:label];
        }
        
        led = [[LEDUI alloc] initWithFrame:ledFrame color:ledColor];
        [iView->myView.view addSubview:led];
        
    }else {
        ofLog()<<"Warning: DigitalIn Pin" << pinNumber << " was initialized without UI element!";
    }    
}


STATE DigitalIn::digitalRead(){
    
    if (DIGITAL_PWM[pinNumber] == 1) {
        return HIGH;
    } else {
        return LOW;
    }
}

void DigitalIn::attach(bool &variable){

    DIGITAL_PWM[pinNumber] ? variable = true : variable = false;
}

void DigitalIn::attach(iTextField *textField){
    
    DIGITAL_PWM[pinNumber] ? textField->setText("True") : textField->setText("false");
}

void DigitalIn::update(ofEventArgs &Args){
    
    if (withUI) {
        if (tempState != DIGITAL_PWM[pinNumber]) {
            tempState = DIGITAL_PWM[pinNumber];
            tempState ? [led setOn] : [led setOff];
        }
    }
}

