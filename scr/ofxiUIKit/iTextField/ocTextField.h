/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 * ocTextField.h
 *
 * Created by Wang Yufan on 8/20/12.
 * Copyright (c) 2012 CIID. All rights reserved.
 * +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 */

#import <UIKit/UIKit.h>

@interface ocTextField : UIView<UITextFieldDelegate>{
    
    UITextField *myTextField;
}

@property(nonatomic, strong) UITextField *myTextField;

@end
