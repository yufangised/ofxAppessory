/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iButton.h
 *
 * Created by Wang Yufan on 7/28/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ofMain.h"
#include "ofEvents.h"
#include "ofxiPhoneExtras.h"
#import  "ocButton.h"
#import  "iViewController.h"


class iButton{
    
public:
    iButton         (float x, float y, float width);  //default height = 37.0f default 
                                                      //type = RoundedRect
    
    iButton         (float x, float y, float width, float height);
    
    ~iButton        ();
    
    void            setTitle(string normal, string highlighted);
    void            setTitleFontSize(float size);
    void            setTitleColorNomarl(int r, int g, int b, int a);
    void            setTitleColorHighligted(int r, int g, int b, int a);
    void            customizeWithImage(string imageForNormal, string imageForHighlighted);
    
    void            addToView(iViewController *iView);
    
    // events
    ofEvent<bool>   pressed;
    ofEvent<bool>   released;
	
private:
    // private properties 
    ocButton        *button; 
    CGRect          buttonFrame;
    float           fontSize;
    
    // private event
    void            update(ofEventArgs & args);
    
};
