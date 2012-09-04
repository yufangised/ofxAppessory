/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocRoundButton.h
 *
 * Created by Wang Yufan on 7/28/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

class iRoundButton;

@interface ocRoundButton : UIView
{    
    UIButton *myButton;
}

@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic) iRoundButton *parent;

-(id) initWithFrame:(CGRect)frame 
         buttonType:(int) type;

-(void) buttonIsPressed:(id)sender;
-(void) buttonIsTapped:(id)sender;


@end
