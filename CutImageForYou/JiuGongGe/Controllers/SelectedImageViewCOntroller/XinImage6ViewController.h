//
//  XinImage6ViewController.h
//  CutImageForYou
//
//  Created by 北城 on 2018/7/19.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "XinBaseViewController.h"
typedef void(^ImageBlock)(UIImage *image);

@interface XinImage6ViewController : XinBaseViewController
@property (nonatomic,copy) ImageBlock imageBlock;

@property(nonatomic,strong) UIImagePickerController * picker2;

@end
