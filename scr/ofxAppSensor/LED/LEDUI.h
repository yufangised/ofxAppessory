/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * LEDUI.h
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */


#import <UIKit/UIKit.h>

@interface LEDUI : UIView

@property (nonatomic) int colorIndex;

@property (nonatomic, strong) UIColor *ledRedOn;
@property (nonatomic, strong) UIColor *ledRedOff;

@property (nonatomic, strong) UIColor *ledGreenOn;
@property (nonatomic, strong) UIColor *ledGreenOff;

@property (nonatomic, strong) UIColor *ledBlueOn;
@property (nonatomic, strong) UIColor *ledBlueOff;

@property (nonatomic, strong) UIColor *ledYellowOn;
@property (nonatomic, strong) UIColor *ledYellowOff;

@property (nonatomic, strong) UIColor *ledColor;
@property (nonatomic, strong) UIColor *ledOutline;
@property (nonatomic, strong) UIColor *ledHighlight;

- (id)initWithFrame:(CGRect)frame 
              color:(int) index;

-(void) drawRect:(CGRect)rect;

-(void) setOn;
-(void) setOff;


@end
