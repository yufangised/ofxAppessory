/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * DigitalOut.mm
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */


#include <iostream>
#include "DigitalOut.h"

@implementation DigitalOutSwitch
@synthesize whichPin;


-(id) initWithFrame:(CGRect)frame 
                pin:(int)pinNumber
{
    self = [super initWithFrame:frame];
    [self addTarget:self 
             action:@selector(switchToggled:) 
   forControlEvents:UIControlEventValueChanged];
    
    whichPin = pinNumber;
    return self;
    
}


- (void)switchToggled:(id)sender
{
	bool isOn = [sender isOn];
    if (isOn) {
        DIGITAL_PWM[whichPin] = 1;
    }else {
        DIGITAL_PWM[whichPin] = 0;
    }
}

- (void)dealloc{
    [super dealloc];
}




DigitalOut::DigitalOut(DIGITAL_PIN digitalPin){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D';
    
    withUI = false;
    withLabel = false;
    
    labelLength = 0;
    labelWidth = 0;
    
}

DigitalOut::DigitalOut(DIGITAL_PIN digitalPin, float x, float y){

    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D';
    
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = false;
    
    labelLength = 0;
    labelWidth = 0;
    
    switchFrame = CGRectMake(xPosition, yPosition, 60.0f, 27.0f);
    //default Arduino color
    stateColorOfSwitch = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
}

DigitalOut::DigitalOut(DIGITAL_PIN digitalPin, float x, float y, string labelName){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D';
    
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
    labelOffset = 3.0f;
    labelWidth = labelLength * 10 + 5.0f;
    labelFrame = CGRectMake(xPosition, yPosition + 1.0f, labelWidth, 25.0f);
    
    switchFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, 60.0f, 27.0f);
    
    textColorOfLabel = [UIColor whiteColor];
    stateColorOfSwitch = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
}


DigitalOut::~DigitalOut(){
    
    [digitalSwitch dealloc];
    [label dealloc];
    [labelNameString release];
    [stateColorOfSwitch release];
    [textColorOfLabel release];
    [backgroundColorOfLabel release];

}

void DigitalOut::setSwitchOnColor(int r, int g, int b, int a){
    if (withUI) {
        stateColorOfSwitch = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                           green:ofClamp(g, 0, 255)/255.0f 
                                            blue:ofClamp(b, 0, 255)/255.0f 
                                           alpha:ofClamp(a, 0, 255)/255.0f];
    }
}



void DigitalOut::setLabelTextColor(int r, int g, int b, int a){
    if (withLabel) {
        textColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                           green:ofClamp(g, 0, 255)/255.0f 
                                            blue:ofClamp(b, 0, 255)/255.0f 
                                           alpha:ofClamp(a, 0, 255)/255.0f];
    }
    
    
}

void DigitalOut::setLabelBackgroundColor(int r, int g, int b, int a){
    if (withLabel) {
        backgroundColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                                 green:ofClamp(g, 0, 255)/255.0f 
                                                  blue:ofClamp(b, 0, 255)/255.0f 
                                                 alpha:ofClamp(a, 0, 255)/255.0f];
    }
}

void DigitalOut::attachTo(bool variable){

    variable ? DIGITAL_PWM[pinNumber] = 1 : DIGITAL_PWM[pinNumber] = 0;
}

void DigitalOut::attachTo(iSwitch *aSwitch){
    
    aSwitch->getState()? DIGITAL_PWM[pinNumber] = 1 : DIGITAL_PWM[pinNumber] = 0;
}

void DigitalOut::attachTo(DigitalIn *digitalIn){

    DIGITAL_PWM[digitalIn->pinNumber] ? DIGITAL_PWM[pinNumber] = 1 : DIGITAL_PWM[pinNumber] = 0;

}


void DigitalOut::addToView(iViewController *iView){
    
    if (withUI) {
        if (withLabel) {
            
            label = [[Label alloc] initWithFrame:labelFrame
                                            name:labelNameString
                                      labelColor:backgroundColorOfLabel
                                       textColor:textColorOfLabel];
            
            [iView->myView.view addSubview:label];
        }
    
    digitalSwitch = [[DigitalOutSwitch alloc] initWithFrame:switchFrame 
                                                        pin:pinNumber];
    digitalSwitch.onTintColor = stateColorOfSwitch;
    digitalSwitch.onText = @"H";
    digitalSwitch.offText = @"L";
    [digitalSwitch setOn:NO animated:YES];
            
    [iView->myView.view addSubview:digitalSwitch];
    
    }else {
        ofLog()<<"Warning: DigitalOut Pin" << pinNumber << " was initialized without UI element!";
    }
}
    

void DigitalOut::digitalWrite(STATE state)
{   
    state ? DIGITAL_PWM[pinNumber] = 1 : DIGITAL_PWM[pinNumber] = 0;
}

@end
