/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iScrollView.mm
 *
 * Created by Wang Yufan on 8/21/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import "ocScrollView.h"
#import "iScrollView.h"


@implementation ocScrollView
@synthesize parent;

- (id) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    [self setDelegate:self];
    return self;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /* Gets called when user scrolls or drags */
    self.alpha = 0.7f; 
}

- (void)scrollViewDidEndDecelerating:(ocScrollView *)scrollView{ /* Gets called only after scrolling */
    
    self.alpha = 1.0f; 
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate{
    /* Make sure the alpha is reset even if the user is dragging */
    self.alpha = 1.0f; 
}

- (UIView *)viewForZoomingInScrollView: (UIScrollView *) scrollView{

    return  parent->imageView;
}


@end


iScrollView::iScrollView(string imageName){
        
    image = [UIImage imageNamed:ofxStringToNSString(imageName)];
    imageView = [[UIImageView alloc] initWithImage:image];
    
    float screenWidth = [UIScreen mainScreen].applicationFrame.size.width;
    float screenHeight = [UIScreen mainScreen].applicationFrame.size.height;
    scrollFrame = CGRectMake(0.0f, 0.0f, screenWidth, screenHeight);
    
    scrollView = [[ocScrollView alloc] initWithFrame:scrollFrame];
    [scrollView addSubview:imageView];
    scrollView.contentSize = imageView.bounds.size;
    
    scrollView.parent = this;

    //[scrollView setPagingEnable:NO];
    
    [scrollView setMinimumZoomScale:1];
    [scrollView setMaximumZoomScale:5];
    
   // scrollView.iScrollView
  
}



iScrollView::~iScrollView()
{
    
}

void iScrollView::setFrame(float x, float y, float width, float height){
    
   
    scrollFrame = CGRectMake(x, y, width, height);
    scrollView.frame = scrollFrame;
    
}

void iScrollView::setZoomingScale(float minmumScale, float maxmumScale){
    
    if (minmumScale < maxmumScale) {
        [scrollView setMinimumZoomScale:minmumScale];
        [scrollView setMaximumZoomScale:maxmumScale];
    }else{
        [scrollView setMinimumZoomScale:maxmumScale];
        [scrollView setMaximumZoomScale:minmumScale];
        ofLog() << "Warning: Zooming scale was set wrong!";
    }
    
}


void iScrollView::addToView(iViewController *iView){
    
    [iView->myView.view addSubview:scrollView];
}

