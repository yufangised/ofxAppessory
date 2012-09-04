/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * Button.h
 *
 * Created by Wang Yufan on 7/30/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofEvents.h"
#import  "ARDUINO_DEFINE.h"

class Button
{
public:     
    Button              (DIGITAL_PIN digitalPin);
    ~Button             (void);
    
    bool                state();
	
    ofEvent <bool>      pressed;
    ofEvent <bool>      released;
    
    int                 pinNumber;

private:
    
    bool                currentStage;    
    bool                tempState;
    void                update(ofEventArgs & args);
};
