//
//  BCJiuGongGeImageManager.h
//  CutImageForYou
//
//  Created by 北城 on 2018/5/31.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCJiuGongGeImageManager : NSObject

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
//调用系统震动模拟手感
+ (void)maDaKaiShiZhenDong;
//弹出星星评论
+ (void)showAppStoreReView;
@end
