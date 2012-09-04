/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocSwitch.h
 *
 * Created by Wang Yufan on 7/26/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>
#import "DCRoundSwitch.h"

class iSwitch;

@interface ocSwitch : DCRoundSwitch
{    
      
}

- (void)switchToggled:(id)sender;

@property (nonatomic)   iSwitch *parent;


@end
