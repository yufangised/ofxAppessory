/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocViewController.h
 *
 * Created by Wang Yufan on 7/27/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */


#import <UIKit/UIKit.h>

@interface ocViewController : UIViewController{

    bool              viewLoaded;
    int       viewOrientation;
};

@property (nonatomic) bool viewLoaded;
@property (nonatomic) int viewOrientation;

-(id) initWithOrientation:(int)orientation;

@end
