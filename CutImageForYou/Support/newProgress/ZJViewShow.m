//
//  ZJViewShow.m
//  test1222
//
//  Created by mac on 16/12/23.
//  Copyright © 2016年 zhangjian. All rights reserved.
//

#import "ZJViewShow.h"
@interface ZJViewShow (){
    BOOL animating;
    UIView *bgView;
    UIView *bg1;
    UIImageView *bgImageView1;
    UIImageView *bgImageView2;
}

@property (nonatomic, strong) UIView  *contentView;

@end

@implementation ZJViewShow


- (instancetype)initWithFrame:(CGRect)frame WithTitleString:(NSString *)titleString WithIamgeName:(NSString *)nameString
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleString = titleString;
        _nameString = nameString;
        [self layoutAllSubviews];
    }
    return self;
}


- (void)layoutAllSubviews{
    
        UIView *bgViews = [[UIView alloc] initWithFrame:self.frame];
        bgViews.alpha = 0.6;
        bgViews.backgroundColor = [UIColor blackColor];
        [self addSubview:bgViews];
    
    
    self.backgroundColor = [UIColor clearColor];
    
    bgView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth -kAUTOWIDTH(191))/2, self.frame.size.height / 2 - kAUTOHEIGHT(40), kAUTOWIDTH(191), 81)];
    [self addSubview:bgView];
    

   self.bgImageView = [[UIImageView alloc] initWithFrame:bgView.frame];
    self.bgImageView.image = [UIImage imageNamed:@"d.png"];
    [self addSubview:self.bgImageView];
    
    self.bgImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
             self.bgImageView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];
    
    
    
    bg1 = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 61, 61)];
    [self.bgImageView addSubview:bg1];
    
    bgImageView1 = [[UIImageView alloc] initWithFrame:bg1.frame];
    bgImageView1.image = [UIImage imageNamed:@"c1.png"];
    [self.bgImageView addSubview:bgImageView1];
    
    bgImageView2 = [[UIImageView alloc] initWithFrame:bg1.frame];
    bgImageView2.image = [UIImage imageNamed:_nameString];
    [self.bgImageView addSubview:bgImageView2];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(bgImageView1.frame.origin.x + 61 +20 , 10, 120, 61)];
    [self.label setFont:[UIFont systemFontOfSize:15]];
    self.label.text = _titleString;
    [self.bgImageView addSubview:self.label];

    if ([_titleString isEqualToString:@"发送中......"] || [_titleString isEqualToString:@"获取中......"]|| [_titleString isEqualToString:@"Send..."]|| [_titleString isEqualToString:@"Get..."]|| [_titleString isEqualToString:@"获取中......"]|| [_titleString isEqualToString:@"取得中……"]||[_titleString isEqualToString:@"保存中......"]) {
        [self startRotate];
    }

    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 60, 30)];
    button1.backgroundColor = [UIColor redColor];
//    [self addSubview:button1];
    [button1 setTitle:@"停止" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dismissContactView:) forControlEvents:UIControlEventTouchUpInside];
  
}

- (void) rotateWithOptions: (UIViewAnimationOptions) options {
    
    [UIView animateWithDuration: 0.125f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         bgImageView2.transform = CGAffineTransformRotate(bgImageView2.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (animating) {
                                 
                                 [self rotateWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 
                                 [self rotateWithOptions: UIViewAnimationOptionCurveEaseOut];
                             }
                         }
                     }];
}

- (void) startRotate {
    if (!animating) {
        animating = YES;
        [self rotateWithOptions: UIViewAnimationOptionCurveEaseIn];
    }
}

- (void) stopRotate{
    
    animating = NO;
}

#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UIButton *)tapGesture{
    
    [self dismissContactView];
}
-(void)dismissContactView
{
    __weak typeof(self)weakSelf = self;
    
    
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
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
-(void)showView
{
    UIWindow * window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
//    [self show:animated];
    [self startRotate];
}

- (void)cleanUp {
    self.taskInProgress = NO;
    [self dismissContactView];
}











@end
