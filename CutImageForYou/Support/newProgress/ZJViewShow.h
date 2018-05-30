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

@property (assign) BOOL taskInProgress;

- (instancetype)initWithFrame:(CGRect)frame WithTitleString:(NSString *)titleString WithIamgeName:(NSString *)nameString;
@property(nonatomic,copy)NSString *titleString;
@property(nonatomic,copy)NSString *nameString;
@property(nonatomic,strong)UIImageView *bgImageView;

@property(nonatomic,strong)UILabel *label;
-(void)showView;

- (void) startRotate;

- (void) stopRotate;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(ZJProgressHUDCompletionBlock)completion;

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(ZJProgressHUDCompletionBlock)completion;

@property (copy) ZJProgressHUDCompletionBlock completionBlock;

@end
