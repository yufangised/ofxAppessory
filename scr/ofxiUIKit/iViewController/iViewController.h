/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iViewController.h
 *
 * Created by Wang Yufan on 7/27/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include "ocViewController.h"
#include "ofxiPhoneExtras.h"


typedef enum PREDEFINED_BACKGROUND{
    
    WHITE = 0,
    BLACK = 1,
    CLEAR = 2,
    STRIPE = 3,
    TEXTURED = 4,
        
} PREDEFINED_BACKGROUND;

typedef enum FONT_STYLE{
    
    Nomal = 0,
    Bold = 1,
    Italic = 2
    
} FONT_STYLE;


typedef enum TEXT_ALIGNMENT{
    
    CENTER = 0,
    LEFT   = 1,
    RIGHT  = 2
    
} TEXT_ALIGNMENT;

typedef enum TEXT_FIELD_STYLE{
    
    ROUND_RECT = 0,
    LINE = 1,
    BEZEL = 2,
    
} TEXT_FIELD_STYLE;

typedef enum ORIENTATION{
    
    PORTRAIT = 0,
    UPSIDEDOWN = 1,
    LANDSCAPE_RIGHT = 2,
    LANDSCAPE_LEFT = 3
    
    
} ORIENTATION;



class iViewController
{
public:
    iViewController     ();
    iViewController     (string name);
    iViewController     (string name, ORIENTATION orientation);
    
    ~iViewController    ();
    
    void                setBackground(int r, int g, int b, int a);
    void                setBackground(PREDEFINED_BACKGROUND background);
    void                setBackgroundImage(string imageName);
    void                setTabBarIcon(string imageName);
                                      
    void                shareViewWithOpenGL();
    
    ocViewController    *myView;
    
private:
    
    UIColor             *backgroundColor;
    
};
