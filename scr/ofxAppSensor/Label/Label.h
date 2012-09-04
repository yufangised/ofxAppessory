/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * Label.h
 *
 * Created by Wang Yufan on 8/16/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

@interface Label : UIView
{
    NSString *labelName;
    UIColor  *labelColor;
    UIColor  *textColor;

}

@property (nonatomic, strong) NSString *labelName;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *textColor;

- (id)initWithFrame:(CGRect)frame 
               name:(NSString *) nameString
         labelColor:(UIColor *) colorOfLabel
          textColor:(UIColor *) colorOfText;

-(void) drawRect:(CGRect)rect;



@end
