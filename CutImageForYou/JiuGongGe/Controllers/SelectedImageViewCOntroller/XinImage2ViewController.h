//
//  XinImage2ViewController.h
//  CutImageForYou
//
//  Created by 北城 on 2018/7/19.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "XinBaseViewController.h"
typedef void(^ImageBlock)(UIImage *image);

@interface XinImage2ViewController : XinBaseViewController
@property (nonatomic,copy) ImageBlock imageBlock;

@property(nonatomic,strong) UIImagePickerController * picker3;
@property(nonatomic,strong) UIImagePickerController * picker6;
@property(nonatomic,strong) UIImagePickerController * picker7;
@end
