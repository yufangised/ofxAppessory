/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocSlider.h
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

class iSlider;

@interface ocSlider : UISlider
{    
}

-(void) sliderValueChanged:(UISlider*)paramSender;

@property (nonatomic)   iSlider *parent;


@end
