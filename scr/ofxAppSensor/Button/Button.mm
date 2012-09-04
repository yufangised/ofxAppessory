/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * Button.mm
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include <iostream>
#include "Button.h"




Button::Button(DIGITAL_PIN digitalPin){
    
    pinNumber = digitalPin;
    DIGITAL_CONFIG_BUF[pinNumber] = 'd';
    
    tempState = DIGITAL_PWM[pinNumber];
    
    
    ofAddListener(ofEvents().update, this, &Button::update);
}



Button::~Button(){
    
}
    

bool Button::state(){
    
    return  DIGITAL_PWM[pinNumber];
}

void Button::update(ofEventArgs &Args){
    
    //handling events
    DIGITAL_PWM[pinNumber]? currentStage = true : currentStage = false; 
    
    if (tempState != DIGITAL_PWM[pinNumber]) {
        if (tempState == HIGH) {
            tempState = DIGITAL_PWM[pinNumber];
            
            ofNotifyEvent(released, currentStage, this);
        }else{
            tempState = DIGITAL_PWM[pinNumber];
            ofNotifyEvent(pressed, currentStage, this);
        }
    }
    //handling attachTo
    
}