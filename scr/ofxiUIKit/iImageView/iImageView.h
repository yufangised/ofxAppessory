/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iImageView.h
 *
 * Created by Wang Yufan on 8/21/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#pragma once
#import "iViewController.h"


class iImageView
{
public:
    
    iImageView          (string imageName);
    ~iImageView         ();
    
    void                setFrame(float x, float y, float width, float height);
    
    void                addToView(iViewController *iView);
    
    
private:
    
    UIImage             *image;
    UIImageView         *imageView;
    CGRect              imageFrame;
        

};
