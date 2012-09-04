/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * PWM.h
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include <iostream>
#include "PWM.h"
#import "PWMSlider.h"



@implementation PWMSlider
@synthesize whichPin;


-(id) initWithFrame:(CGRect)frame pin:(int)pinNumber
{
    self = [super initWithFrame:frame];
    
    [self addTarget:self 
             action:@selector(sliderValueChanged:) 
   forControlEvents:UIControlEventValueChanged]; 
    
    whichPin = pinNumber;
    
    return self;
    
}
-(void) sliderValueChanged:(UISlider*)paramSender{
    
    int newValue = [paramSender value];
    DIGITAL_PWM[whichPin] = newValue;
    NSLog(@"updating slider value: %d", newValue);
    
}




PWM::PWM(PWM_PIN pwmPin){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    withUI = false;
    withLabel = false;
}

PWM::PWM(PWM_PIN pwmPin, float x, float y, float length){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    
    xPosition = x;
    yPosition = y;
    sliderLength = length;
    labelOffset = 0.0f;
    withUI = true;
    withLabel = false;
    
    sliderFrame = CGRectMake(xPosition, yPosition, sliderLength, 27.0f);
}

PWM::PWM(PWM_PIN pwmPin, float x, float y, float lenght, string labelName){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    
    xPosition = x;
    yPosition = y;
    sliderLength = lenght;
    labelOffset = 0.0f;
    withUI = true;
    withLabel = true;
    
    if(labelName == DEFAULT){
        if (pinNumber < 10) {
            labelLength = 2;
        } else {
            labelLength = 3;
        }
        
        stringstream labelString;
        labelString << "P" << pinNumber;
        labelNameString = ofxStringToNSString(labelString.str());
    }else {
        labelLength = labelName.length();
        labelNameString = ofxStringToNSString(labelName);
    }
    
    labelWidth = labelLength * 10 + 5.0f;
    labelOffset = 3.0f;
    labelFrame = CGRectMake(xPosition, yPosition + 1.0f, labelWidth, 25.0f);
    
    sliderFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, sliderLength, 27.0f); 
    
    textColorOfLabel = [UIColor whiteColor];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
}


PWM::~PWM(){
    
    [pwmSlider dealloc];
    [label dealloc];
    [labelNameString release];
    [textColorOfLabel release];
    [backgroundColorOfLabel release];
    
}

void PWM::setLabelTextColor(int r, int g, int b, int a){
    if (withLabel) {
        textColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                           green:ofClamp(g, 0, 255)/255.0f 
                                            blue:ofClamp(b, 0, 255)/255.0f 
                                           alpha:ofClamp(a, 0, 255)/255.0f];
    }
    
    
}

void PWM::setLabelBackgroundColor(int r, int g, int b, int a){
    if (withLabel) {
        backgroundColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                                 green:ofClamp(g, 0, 255)/255.0f 
                                                  blue:ofClamp(b, 0, 255)/255.0f 
                                                 alpha:ofClamp(a, 0, 255)/255.0f];
    }
}


void PWM::addToView(iViewController *iView){
    
    if (withUI) {
        if (withLabel) {
            
            label = [[Label alloc] initWithFrame:labelFrame 
                                            name:labelNameString 
                                      labelColor:backgroundColorOfLabel 
                                       textColor:textColorOfLabel];
                    
            [iView->myView.view addSubview:label];
        }   
            
        pwmSlider = [[PWMSlider alloc] initWithFrame:sliderFrame 
                                                     pin:pinNumber];
            
        pwmSlider.minimumValue = 0;
        pwmSlider.maximumValue = 255;
    
        [iView->myView.view addSubview:pwmSlider];
        
    }else {
        ofLog()<<"Warning: PWM Pin" << pinNumber << " was initialized without UI element!";
    }
}


void PWM::attactTo(float variable){
    
    DIGITAL_PWM[pinNumber] = (int)(ofClamp(variable, 0, 255));
    
}

void PWM::attachTo(int variable){
    
    DIGITAL_PWM[pinNumber] = (int)(ofClamp(variable, 0, 255));
    
}

void PWM::attachTo(iSlider *slider){
    
    DIGITAL_PWM[pinNumber] =  (int)(ofMap(slider->getValue(), slider->minValue , slider->maxValue, 0, 255));
}

void PWM::analogWrite(int analogValue)
{   
    unsigned int value = ofClamp(analogValue, 0, 255);
    
    DIGITAL_PWM[pinNumber] = value;
    
}

@end
