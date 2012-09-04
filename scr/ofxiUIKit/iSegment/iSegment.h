/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iSegment.h
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#include <stdarg.h>
#include <vector>

#import "ocSegment.h"
#import "iViewController.h"
#include "ofEvents.h"
#include "ofxiPhoneExtras.h"


typedef enum SEGMENT_STYLE
{
    BAR = 0,
    BEZELED = 1,
    BORDERED = 2
    
} SEGMENT_STYLE;


class iSegment
{
public:
    iSegment            (int numberOfSegments, string title, ...);
    ~iSegment           ();
    
    // public methods
    void                setFrame(float x, float y, float width, float height);
    void                setSegmentStyle(SEGMENT_STYLE style);
    void                setSegmentColor(int r, int g, int b, int a);//only for segmentStyle = BAR;
    void                setSelectedSegment(int index);
    void                addToView(iViewController *iView);
    int                 getIndex();
    
    // public properties
    int                 currentIndex;
    
    // event
    ofEvent<int>        segmentChanged;
    
private:
    // pravate properties
    ocSegment           *segment;
    NSMutableArray      *titleArray;
    CGRect              segmentFrame;
    int                 numOfSegments;
    int                 styleOfSegment;
    
};
