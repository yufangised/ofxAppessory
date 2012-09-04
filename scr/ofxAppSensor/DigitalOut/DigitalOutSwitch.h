/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * DigitalOutSwith.h
 *
 * Created by Wang Yufan on 8/15/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>
#import "DCRoundSwitch.h"


//class iSwitch;

@interface DigitalOutSwitch : DCRoundSwitch

@property (nonatomic) int whichPin;

-(id) initWithFrame:(CGRect)frame 
                pin:(int)pinNumber;
@end
