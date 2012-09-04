/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iTableView.h
 *
 * Created by Wang Yufan on 8/2/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#include "ofEvents.h"
#include "ofxiPhoneExtras.h"
#include <stdarg.h>
#include <iostream>
#include <stdio.h>
#include <vector>

#import  "iCellGroup.h"
#import  "ocTableView.h"
#import  "iViewController.h"


typedef enum TABLE_STYLE
{
    GROUPED = 0,
    PLAIN = 1,
    
} TABLE_STYLE;


class iTableView
{
public:
    
    
    iTableView        (iCellGroup *section1); // init with 1 section
    
    iTableView        (iCellGroup *section1,  // init with 2 sections
                       iCellGroup *section2);
    
    iTableView        (iCellGroup *section1,  // init with 3 sections
                       iCellGroup *section2, 
                       iCellGroup *section3);
    
    iTableView        (iCellGroup *section1,  // init with 4 sections
                       iCellGroup *section2, 
                       iCellGroup *section3,
                       iCellGroup *section4);
    
    iTableView        (iCellGroup *section1,  // init with 5 sections
                       iCellGroup *section2, 
                       iCellGroup *section3, 
                       iCellGroup *section4, 
                       iCellGroup *section5);
    
    iTableView        (iCellGroup *section1,  // init with 6 sections
                       iCellGroup *section2, 
                       iCellGroup *section3,
                       iCellGroup *section4,
                       iCellGroup *section5,
                       iCellGroup *section6);
    
    ~iTableView       (void);
    
    void              setDistanceToTop(float distance);
    void              setTableStyle(TABLE_STYLE style);
    void              setBackground(int r, int g, int b, int a);
    void              setBackground(PREDEFINED_BACKGROUND background);
    void              setBackgroundImage(string imageName);
    void              addToView(iViewController *iView);
    
    ocTableView       *myTableView;
    ofEvent<int>      cellSelected;
    
private:
    NSArray           *rowsInSection;
    NSMutableArray    *labelsInSections;
    NSMutableArray    *typeInSections;
    NSMutableArray    *headerAndFooterInSections;
    UIColor           *colorOfBackground;
    
    int               numOfSections;
    int               styleOfTable;
    float             disToTop;
    
    
};

