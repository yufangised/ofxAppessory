//
//  PWMSlider.h
//  emptyExample
//
//  Created by Wang Yufan on 8/15/12.
//  Copyright (c) 2012 CIID. All rights reserved.
//

#import <UIKit/UIKit.h>

class iSlider;

@interface PWMSlider : UISlider

@property (nonatomic) int whichPin;

-(id) initWithFrame:(CGRect)frame pin:(int)pinNumber;
-(void) sliderValueChanged:(UISlider*)paramSender;


@end
