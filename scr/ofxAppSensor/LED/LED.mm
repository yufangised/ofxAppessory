/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * LED.mm
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */


#include "LED.h"

LED::LED(DIGITAL_PIN digitalPin){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D'; 
    withUI = false;
    withLabel = false;
    isPWM = false;
    
    state = OFF;
    
    tempState = DIGITAL_PWM[pinNumber];
    //ofAddListener(ofEvents().update, this, &LED::update);

}

LED::LED(DIGITAL_PIN digitalPin, float x, float y){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = false;
    isPWM = false;
    
    state = OFF;
    
    labelOffset = 0;
    
    ledColor = GREEN;
    ledFrame = CGRectMake(xPosition, yPosition, LED_5MM, LED_5MM);
    
    tempState = DIGITAL_PWM[pinNumber];
    //ofAddListener(ofEvents().update, this, &LED::update);
}

LED::LED(DIGITAL_PIN digitalPin, float x, float y, string labelName){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = true;
    isPWM = false;
    
    state = OFF;
    
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
    
    
    ledColor = GREEN;
    ledFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, LED_5MM, LED_5MM);
    
    textColorOfLabel = [UIColor whiteColor];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
    tempState = DIGITAL_PWM[pinNumber];
    
    //ofAddListener(ofEvents().update, this, &LED::update);

}

LED::LED(DIGITAL_PIN digitalPin, float x, float y, LED_COLOR color, LED_SIZE size){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = false;
    isPWM = false;
    
    state = OFF;

    labelLength = 0;
    labelWidth = 0;
    labelOffset = 0;
    
    ledColor = color;
    
    if (size == LED_3MM) {
        ledFrame = CGRectMake(xPosition, yPosition + (LED_5MM-LED_3MM)/2, size, size);
    }else {
        ledFrame = CGRectMake(xPosition, yPosition, size, size);
    }
    
    tempState = DIGITAL_PWM[pinNumber];
    
    
    //ofAddListener(ofEvents().update, this, &LED::update);
}

LED::LED(DIGITAL_PIN digitalPin, float x, float y, LED_COLOR color, LED_SIZE size, string labelName){

    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'D'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = true;
    isPWM = false;
    
    state = OFF;
    
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
    
    ledColor = color;
    
    if (size == LED_3MM) {
        ledFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition + (LED_5MM-LED_3MM)/2 , size, size);
    }else {
        ledFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, size, size);
    }
    
    textColorOfLabel = [UIColor whiteColor];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
    tempState = DIGITAL_PWM[pinNumber];
    //ofAddListener(ofEvents().update, this, &LED::update);
}

LED::LED(PWM_PIN pwmPin){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    withUI = false;
    withLabel = false;
    isPWM = true;
    
    state = OFF;
    
    tempValue = DIGITAL_PWM[pinNumber];
    //ofAddListener(ofEvents().update, this, &LED::update);
    
}

LED::LED(PWM_PIN pwmPin, float x, float y){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = false;
    isPWM = true;
    
    state = OFF;
    
    labelOffset = 0;
    
    ledColor = GREEN;
    ledFrame = CGRectMake(xPosition, yPosition, LED_5MM, LED_5MM);
    
    tempValue = DIGITAL_PWM[pinNumber];
    //ofAddListener(ofEvents().update, this, &LED::update);
}

LED::LED(PWM_PIN pwmPin, float x, float y, string labelName){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = true;
    isPWM = true;
    
    state = OFF;
    
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
    
    
    ledColor = GREEN;
    ledFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, LED_5MM, LED_5MM);
    
    textColorOfLabel = [UIColor whiteColor];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
    tempValue = DIGITAL_PWM[pinNumber];
    
    //ofAddListener(ofEvents().update, this, &LED::update);
    
}

LED::LED(PWM_PIN pwmPin, float x, float y, LED_COLOR color, LED_SIZE size){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = false;
    isPWM = true;
    
    state = OFF;

    labelOffset = 0;
    
    ledColor = color;
    
    if (size == LED_3MM) {
        ledFrame = CGRectMake(xPosition, yPosition + (LED_5MM-LED_3MM)/2, size, size);
    }else {
        ledFrame = CGRectMake(xPosition, yPosition, size, size);
    }
    
    tempValue = DIGITAL_PWM[pinNumber];
    
    
    //ofAddListener(ofEvents().update, this, &LED::update);
}

LED::LED(PWM_PIN pwmPin , float x, float y, LED_COLOR color, LED_SIZE size, string labelName){
    
    pinNumber = pwmPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'A'; 
    xPosition = x;
    yPosition = y;
    
    withUI = true;
    withLabel = true;
    isPWM = true;
    
    state = OFF;
    
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
    
    ledColor = color;
    
    if (size == LED_3MM) {
        ledFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition + (LED_5MM-LED_3MM)/2 , size, size);
    }else {
        ledFrame = CGRectMake(xPosition+labelWidth+labelOffset, yPosition, size, size);
    }
    
    textColorOfLabel = [UIColor whiteColor];
    backgroundColorOfLabel = [UIColor colorWithRed:0/255.0f green:119/255.0f blue:122/255.0f alpha:1];
    
    tempValue = DIGITAL_PWM[pinNumber];
    //ofAddListener(ofEvents().update, this, &LED::update);
}



LED::~LED(){
    
    [led dealloc];
    [label dealloc];
    [labelNameString release];
    [textColorOfLabel release];
    [backgroundColorOfLabel release];
    
}

void LED::setLabelTextColor(int r, int g, int b, int a){
    if (withLabel) {
        textColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                           green:ofClamp(g, 0, 255)/255.0f 
                                            blue:ofClamp(b, 0, 255)/255.0f 
                                           alpha:ofClamp(a, 0, 255)/255.0f];
    }
    
    
}
void LED::setLabelBackgroundColor(int r, int g, int b, int a){
    if (withLabel) {
        backgroundColorOfLabel = [UIColor colorWithRed:ofClamp(r, 0, 255)/255.0f 
                                                 green:ofClamp(g, 0, 255)/255.0f 
                                                  blue:ofClamp(b, 0, 255)/255.0f 
                                                 alpha:ofClamp(a, 0, 255)/255.0f];
    }
}


void LED::setOn(){
    
    if (isPWM == true) {
        state = ON;
        DIGITAL_PWM[pinNumber] = 255;
        [led setOn];
    } else {
        state = ON;
        DIGITAL_PWM[pinNumber] = 1;
        [led setOn];
    }
    
}
void LED::setOff(){
        
    if (isPWM == true) {
        state = OFF;
        DIGITAL_PWM[pinNumber] = 0;
        [led setOff];
    } else {
        state = OFF; 
        DIGITAL_PWM[pinNumber] = 0;
        [led setOff];
    }
}

void LED::setBrightness(int pwmValue){

    if (isPWM == true) {
        DIGITAL_PWM[pinNumber] = (int)(ofClamp(pwmValue, 0, 255));
    }else {
        ofLog() << "Warning: LED method: setBrightness(int) is not available when a LED is not connected to a PWM pin!";
    }
    
}

void LED::attachTo(bool variable){

    if(isPWM){
        variable ? DIGITAL_PWM[pinNumber] = 255 : DIGITAL_PWM[pinNumber] = 0;
    } else {
        variable ? DIGITAL_PWM[pinNumber] = 1 : DIGITAL_PWM[pinNumber] = 0;
    }
}

void LED::attachTo(int variable, int rangeMinimum, int rangeMaximum){
    
    if(isPWM){
        DIGITAL_PWM[pinNumber] = (int) (ofMap(variable, rangeMinimum, rangeMaximum, 0, 255));
    } else {
        ofLog() << "Warning: LED method: attachTo(int variable, int rangeMinmum, int rangeMax); is not available when a LED is connected to a PWM pin!";
    }
}

void LED::attachTo(iSwitch *aSwitch){

    if (isPWM) {
        aSwitch->getState() ? DIGITAL_PWM[pinNumber] = 255 : DIGITAL_PWM[pinNumber] = 0;
    }else{
        aSwitch->getState() ? DIGITAL_PWM[pinNumber] = 1 : DIGITAL_PWM[pinNumber] = 0;
    }
}

void LED::attachTo(DigitalIn *digitalIn){
    
    if (isPWM) {
        DIGITAL_PWM[digitalIn->pinNumber] ? DIGITAL_PWM[pinNumber] = 255 : DIGITAL_PWM[pinNumber] = 0;
    }else{
        DIGITAL_PWM[digitalIn->pinNumber] ? DIGITAL_PWM[pinNumber] = 1 : DIGITAL_PWM[pinNumber] = 0;
    }
    
}

void LED::addToView(iViewController *iView){
    
    if (withUI) {
        
        if (withLabel) {
        
            label = [[Label alloc] initWithFrame:labelFrame 
                                            name:labelNameString 
                                      labelColor:backgroundColorOfLabel 
                                       textColor:textColorOfLabel];
               
            // [iView->myView.view addSubview:label];
        }
    
        led = [[LEDUI alloc] initWithFrame:ledFrame color:ledColor];
    
        [iView->myView.view addSubview:led];

    }
}

void LED::update(ofEventArgs &Args){
    
}
