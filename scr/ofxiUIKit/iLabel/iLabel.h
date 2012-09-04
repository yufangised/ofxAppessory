/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iLabel.h
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#import "iViewController.h"
#include "ofEvents.h"
#include "ofxiPhoneExtras.h"

class iLabel
{
public:
    iLabel         (string text);
    iLabel         (string text, int numberOfLines);
    ~iLabel        ();
    
    void            setFrame(float x, float y, float width, float height);
    
    void            setBackground(int r, int g, int b, int a);
    void            setBackground(PREDEFINED_BACKGROUND background);
    void            setTextColor(int r, int g, int b, int a);
    
    void            setFont(float fontSize);
    void            setFont(float fontSize, FONT_STYLE style);
    void            setFont(float fontSize, FONT_STYLE style, bool withShadow);
    
    void            setTextAlignment(TEXT_ALIGNMENT alignment);
    
    void            addToView(iViewController *iView);
    
private:
    UIColor         *colorOftext;
    UIColor         *colorOfBackground;
    UILabel         *label;  
    NSString        *textOflabel;
    CGRect          labelFrame;
    
    int             styleOfFont;
    int             numOfLines;
    int             alignmentOfText;
    float           sizeOfFont;
    bool            isWithShadow;
    
};
