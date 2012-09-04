/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iImageView.h
 *
 * Created by Wang Yufan on 8/21/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "iImageView.h"


iImageView::iImageView(string imageName){
        
    image = [UIImage imageNamed:ofxStringToNSString(imageName)];
    imageView = [[UIImageView alloc] initWithImage:image];
    
    float screenWidth = [UIScreen mainScreen].applicationFrame.size.width;
    float screenHeight = [UIScreen mainScreen].applicationFrame.size.height;
    imageFrame = CGRectMake(0.0f, 0.0f, screenWidth, screenHeight);
    imageView.frame = imageFrame;
}



iImageView::~iImageView()
{
    
}

void iImageView::setFrame(float x, float y, float width, float height){
    
   
    imageFrame = CGRectMake(x, y, width, height);
    imageView.frame = imageFrame;
    
}


void iImageView::addToView(iViewController *iView){
    
    [iView->myView.view addSubview:imageView];
}

