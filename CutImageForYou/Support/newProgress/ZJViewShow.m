//
//  ZJViewShow.m
//  test1222
//
//  Created by mac on 16/12/23.
//  Copyright © 2016年 zhangjian. All rights reserved.
//

#import "ZJViewShow.h"
@interface ZJViewShow (){
    BOOL _animating;//是否在动画中
    UIView *_bgView;//白色背景视图的父视图
    UIView *_bgImageViewYuanQuan; //
    UIImageView *_bgImageViewBlow; //下面圆圈淡灰色视图
    UIImageView *_bgImageViewAbove;//上层转圈视图
}

@end

@implementation ZJViewShow

- (instancetype)initWithFrame:(CGRect)frame WithTitleString:(NSString *)titleString WithIamgeName:(NSString *)nameString{
    self = [super initWithFrame:frame];
    if (self) {
        _titleString = titleString;
        _nameString = nameString;
        [self layoutAllSubviews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutAllSubviews{
    
    UIView *bgMaskView = [[UIView alloc] initWithFrame:self.frame];
    bgMaskView.backgroundColor = [UIColor blackColor];
    [self addSubview:bgMaskView];
    bgMaskView.alpha = 0.6;
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth -kAUTOWIDTH(191))/2, self.frame.size.height / 2 - kAUTOHEIGHT(40), kAUTOWIDTH(191), 81)];
    [self addSubview:_bgView];
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:_bgView.frame];
    self.bgImageView.image = [UIImage imageNamed:@"d.png"];
    [self addSubview:self.bgImageView];
    
    self.bgImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f delay:0  usingSpringWithDamping:1.0 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
                         self.bgImageView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];
    
    _bgImageViewYuanQuan = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 61, 61)];
    
    _bgImageViewBlow = [[UIImageView alloc] initWithFrame:_bgImageViewYuanQuan.frame];
    _bgImageViewBlow.image = [UIImage imageNamed:@"c1.png"];
    
    _bgImageViewAbove = [[UIImageView alloc] initWithFrame:_bgImageViewYuanQuan.frame];
    _bgImageViewAbove.image = [UIImage imageNamed:_nameString];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(_bgImageViewBlow.frame.origin.x + 61 +20 , 10, 120, 61)];
    self.label.font = [UIFont fontWithName:@"HeiTi SC" size:15];
    self.label.text = _titleString;
    
    [self.bgImageView addSubview:self.label];
    [self.bgImageView addSubview:_bgImageViewYuanQuan];
    [self.bgImageView addSubview:_bgImageViewBlow];
    [self.bgImageView addSubview:_bgImageViewAbove];
    
//    如果显示的字样为这几个则转圈
    if ([_titleString isEqualToString:@"发送中......"] || [_titleString isEqualToString:@"获取中......"]|| [_titleString isEqualToString:@"Send..."]|| [_titleString isEqualToString:@"Get..."]|| [_titleString isEqualToString:@"获取中......"]|| [_titleString isEqualToString:@"取得中……"]||[_titleString isEqualToString:@"保存中......"]) {
        [self startRotate];
    }
}

- (void)rotateWithOptions: (UIViewAnimationOptions) options {
    
    [UIView animateWithDuration: 0.125f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         _bgImageViewAbove.transform = CGAffineTransformRotate(_bgImageViewAbove.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (_animating) {
                                 [self rotateWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 [self rotateWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}

- (void)startRotate {
    if (!_animating) {
        _animating = YES;
        [self rotateWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
}

- (void)stopRotate{
    _animating = NO;
}

#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UIButton *)tapGesture{
    [self dismissContactView];
}
-(void)dismissContactView{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
                         self.bgImageView.transform = CGAffineTransformMakeScale(0.1, 0.11);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.5 animations:^{
                             weakSelf.alpha = 0;
                         } completion:^(BOOL finished) {
                             [weakSelf stopRotate];
                             [weakSelf removeFromSuperview];
                         }];
                     }];
}

// 这里加载在了window上
-(void)showView{
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
}

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block completionBlock:(ZJProgressHUDCompletionBlock)completion{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self showAnimated:animated whileExecutingBlock:block onQueue:queue completionBlock:completion];
}

- (void)showAnimated:(BOOL)animated whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue
     completionBlock:(ZJProgressHUDCompletionBlock)completion {
    self.taskInProgress = YES;
    self.completionBlock = completion;
    dispatch_async(queue, ^(void) {
        block();
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self cleanUp];
        });
    });
    [self startRotate];
}

- (void)cleanUp{
    self.taskInProgress = NO;
    [self dismissContactView];
}


@end

