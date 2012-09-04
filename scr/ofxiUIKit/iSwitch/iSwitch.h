/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iSwitch.h
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofEvents.h"
#import "ocSwitch.h"
#import "iViewController.h"
#import "ARDUINO_DEFINE.h"
#import "DigitalOut.h"
#import "LED.h"

class LED;
class DigitalOut;


class iSwitch
{
public:
    iSwitch         (float x, float y);
    iSwitch         (float x, float y, float width, float height);
    
    ~iSwitch        ();
    
    bool            getState();
    void            addToView(iViewController *iView);
    
	bool            setState(bool state);
    void            setSwitchOnColor(int r, int g, int b, int a);
    void            setSwitchText(string onText, string offText);
    
    void            attach(bool &variable);
    void            attach(LED *led);
    void            attach(DigitalOut *digitalOut);
    
    
private:
    
    ocSwitch        *mySwitch; 
    UIColor         *stageColorOfSwitch;
    CGRect          switchFrame;
        
public:
    ofEvent<bool>   toggled;
};
