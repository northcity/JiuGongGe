//
//  Factory.h
//  UINavigationControllerDemo2
//
//  Created by wanghailong on 16/1/4.
//  Copyright © 2016年 HailongExcellency. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Factory : NSObject

//创建Label
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame fontSize:(CGFloat)size;
+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size;

//创建Button
+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)selector;

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor  target:(id)target action:(SEL)selector;

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor  backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)selector;

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)selector;

//创建UIView
+ (UIView *)createViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color;

//创建UITextField
+ (UITextField *)createTextFieldWithPlaceHolder:(NSString *)placeholder frame:(CGRect)frame;

+ (UITextField *)createTextFieldWithPlaceHolder:(NSString *)placeholder frame:(CGRect)frame text:(NSString *)text boardStyle:(UITextBorderStyle)style;

@end










