//
//  ZJViewShow.h
//  test1222
//
//  Created by mac on 16/12/23.
//  Copyright © 2016年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

#if NS_BLOCKS_AVAILABLE
typedef void (^ZJProgressHUDCompletionBlock)();
#endif

@interface ZJViewShow : UIView


- (instancetype)initWithFrame:(CGRect)frame WithTitleString:(NSString *)titleString WithIamgeName:(NSString *)nameString;
- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(ZJProgressHUDCompletionBlock)completion;
- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue completionBlock:(ZJProgressHUDCompletionBlock)completion;

@property(nonatomic,strong)UILabel *label;//显示提示的Label
@property(nonatomic,copy)NSString *titleString;//label的字
@property(nonatomic,copy)NSString *nameString;//上层imageView的Image名字
@property(nonatomic,assign) BOOL taskInProgress;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,copy) ZJProgressHUDCompletionBlock completionBlock;

- (void) showView;
- (void) startRotate;
- (void) stopRotate;


@end
