/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocButton.h
 *
 * Created by Wang Yufan on 7/28/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

class iButton;

@interface ocButton : UIView
{    
    UIButton *myButton;
}

@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic) iButton *parent;

-(id) initWithFrame:(CGRect)frame;
-(void) buttonIsPressed:(id)sender;
-(void) buttonIsTapped:(id)sender;


@end
