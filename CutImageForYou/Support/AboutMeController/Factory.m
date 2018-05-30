//
//  Factory.m
//  UINavigationControllerDemo2
//
//  Created by wanghailong on 16/1/4.
//  Copyright © 2016年 HailongExcellency. All rights reserved.
//

#import "Factory.h"

@implementation Factory

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame {
    return [self createLabelWithTitle:title frame:frame fontSize:14.f];
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color {
    return [self createLabelWithTitle:title frame:frame textColor:color fontSize:14.f];
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame fontSize:(CGFloat)size {
    return [self createLabelWithTitle:title frame:frame textColor:[UIColor blackColor] fontSize:size];
}

+ (UILabel *)createLabelWithTitle:(NSString *)title frame:(CGRect)frame textColor:(UIColor *)color fontSize:(CGFloat)size {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame  target:(id)target action:(SEL)selector {
    return [self createButtonWithTitle:title frame:frame backgroundColor:[UIColor orangeColor] target:target action:selector];
}

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor  target:(id)target action:(SEL)selector {
    return [self createButtonWithTitle:title frame:frame backgroundColor:backgroundColor backgroundImage:nil target:target action:selector];
}

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor  backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)selector {
    //返回的时候调用最全的那个方法，并且把返回值返回即可
    return [self createButtonWithTitle:title frame:frame backgroundColor:backgroundColor image:nil backgroundImage:backImage target:target action:selector];
}

+ (UIButton *)createButtonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor image:(UIImage *)image backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)selector {
    //实例化一个button也是我们创建后回传的button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //根据传入的frame设置尺寸
    button.frame = frame;
    //根据传入的title设置title
    [button setTitle:title forState:UIControlStateNormal];
    //根据传入的image 设置内容图片
    [button setImage:image forState:UIControlStateNormal];
    //根据传入的背景图片设置按钮的背景图片
    [button setBackgroundImage:backImage forState:UIControlStateNormal];
    //设置背景色
    button.backgroundColor = backgroundColor;
    //为这个按钮绑定事件持有者和响应方法和响应条件
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIView *)createViewWithFrame:(CGRect)frame backgroundColor:(UIColor *)color {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}

+ (UITextField *)createTextFieldWithPlaceHolder:(NSString *)placeholder frame:(CGRect)frame {
    return [self createTextFieldWithPlaceHolder:placeholder frame:frame text:nil boardStyle:UITextBorderStyleRoundedRect];
}

//创建textField的工具方法
+ (UITextField *)createTextFieldWithPlaceHolder:(NSString *)placeholder frame:(CGRect)frame text:(NSString *)text boardStyle:(UITextBorderStyle)style {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.borderStyle = style;
    textField.text = text;
    return textField;
}

@end









