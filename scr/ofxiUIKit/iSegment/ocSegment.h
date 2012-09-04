/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * iSegment.h
 *
 * Created by Wang Yufan on 7/2612.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

class iSegment;

@interface ocSegment : UISegmentedControl

-(void) segmentIsChanged:(UISegmentedControl *)paramSender;

@property (nonatomic)   iSegment *parent;


@end
