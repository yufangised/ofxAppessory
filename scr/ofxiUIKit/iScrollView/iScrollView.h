/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iScrollView.h
 *
 * Created by Wang Yufan on 8/21/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once

#import "iViewController.h"
#import "ocScrollView.h"


class iScrollView
{
public:
    
    iScrollView         (string imageName);
    ~iScrollView        ();
    
    void                setFrame(float x, float y, float width, float height);
    void                addToView(iViewController *iView);
    void                setZoomingScale(float minmumScale, float maxmumScale);
    UIImageView         *imageView;
    
private:
    
    UIImage             *image;
    
    ocScrollView        *scrollView;
    CGRect              scrollFrame;
        

};
