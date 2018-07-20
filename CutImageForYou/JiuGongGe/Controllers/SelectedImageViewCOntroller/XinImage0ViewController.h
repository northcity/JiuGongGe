//
//  XinImage0ViewController.h
//  CutImageForYou
//
//  Created by 北城 on 2018/7/19.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XinBaseViewController.h"

typedef void(^ImageBlock)(UIImage *image);
@interface XinImage0ViewController : XinBaseViewController
@property (nonatomic,copy) ImageBlock imageBlock;
@end
