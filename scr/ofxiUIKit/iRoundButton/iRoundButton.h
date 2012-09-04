/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iRoundButton.h
 *
 * Created by Wang Yufan on 7/28/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once

#include "ofEvents.h"
#import "ocRoundButton.h"
#import "iViewController.h"

typedef enum ROUND_BUTTON_TYPE{
    
    DETAIL_DISCLOSURE = 0,
    INFO_LIGHT = 1,
    INFO_DARK = 2,
    CONTACT_ADD = 3, 
    
} ROUND_BUTTON_TYPE;


class iRoundButton
{
public:
    iRoundButton       (float x, float y, ROUND_BUTTON_TYPE type);
    ~iRoundButton      ();
    
    void                addToView(iViewController *iView);
    
    ofEvent<bool>       pressed;
    ofEvent<bool>       released;
	
private:
    
    ocRoundButton       *roundButton;    
    CGRect              buttonFrame;         

    
};
