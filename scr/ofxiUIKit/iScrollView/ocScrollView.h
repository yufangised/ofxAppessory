/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocScrollView.h
 *
 * Created by Wang Yufan on 8/21/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

class iScrollView;

@interface ocScrollView : UIScrollView <UIScrollViewDelegate>{

}

@property (nonatomic)  iScrollView *parent;

@end
