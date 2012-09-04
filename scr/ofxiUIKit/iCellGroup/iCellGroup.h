/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iCellGroup.h
 *
 * Created by Wang Yufan on 8/1/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include "UIKit/UIKit.h"
#include <stdarg.h>
#include <iostream>
#include <stdio.h>
#include <vector>
#include "ofEvents.h"
#include "ofxiPhoneExtras.h"


typedef enum ACCESSORY_TYPE
{
    NONE = 0,
    DETIAL_INDICATOR = 1,
    DETIAL_BUTTON = 2
    
} ACCESSORY_TYPE;


class iCellGroup
{
public:
    
    iCellGroup              (int numberOfCells, string cellLabel, ...);
    ~iCellGroup             ();
    
    void                    headerAndFooter(string header, string footer);
    void                    setAccessoryType(ACCESSORY_TYPE type, ...);
    int                     numOfCells;
    bool                    isTypeDefined;
    
    std::vector<string>     cellLabels;
    std::vector<string>     headerAndFooterInfo;
    std::vector<int>        accessoryTypes;

private: 
    UITableViewCell         *cell;
};


