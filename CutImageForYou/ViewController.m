//
//  ViewController.m
//  CutImageForYou
//
//  Created by chenxi on 2018/5/11.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "ViewController.h"
#import "STPhotoBroswer.h"
#import <CoreMotion/CoreMotion.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZJViewShow.h"
#import "SettingViewController.h"
#import<AudioToolbox/AudioToolbox.h>
#import <StoreKit/StoreKit.h>

@interface ViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    CGFloat _lastScale;//记录最后一次的图片放大倍数
    BOOL _isImagesSavedFailed;
}
@property(nonatomic,strong)UIImageView *yuanTuImageView;
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic)BOOL zoomOut_In;

@property(nonatomic,strong)UIImageView * backGroundImageView;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property(nonatomic,strong)UIBlurEffect *effect;
@property(nonatomic,strong)UIImage *selectedImage;
@property(nonatomic,strong) ALAssetsLibrary *assetsLibrary;
@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)UIView *getDownBtnView;
@property(nonatomic,strong)UIView *backBtnView;
@property(nonatomic,strong)UIView *shareBtnView;

@property(nonatomic,strong)UIButton *jiuBtn;
@property(nonatomic,strong)UIButton *siBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createAboutBtn];
        [self createSelectedButton];
    });
   
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)kaiShiZhenDong{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleLight];
        [impactLight impactOccurred];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleMedium];
            [impactLight impactOccurred];
            
        });
    }else{
        AudioServicesPlaySystemSound(1519);
    }
}
- (void)createAboutBtn{
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    self.imageArray = [[NSMutableArray alloc]init];


    UISwipeGestureRecognizer * recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(presentAboutMeController:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.view addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(selectedXiangCeImage)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:recognizer];
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - kAUTOWIDTH(50))/2, ScreenHeight - 100, kAUTOWIDTH(50), kAUTOHEIGHT(50))];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(presentAboutMeController:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth - kAUTOWIDTH(50))/2, button.frame.origin.y + kAUTOHEIGHT(50), kAUTOWIDTH(50), 1)];
    lineView.tag = 200;
    [self.view addSubview:button];
    [self.view addSubview:lineView];
    lineView.backgroundColor = [UIColor whiteColor];
    
    if (PNCisIPAD) {
        lineView.frame = CGRectMake((ScreenWidth - kAUTOWIDTH(50))/2, button.frame.origin.y + 50, kAUTOWIDTH(50), 1);
    }
}

- (void)presentAboutMeController:(UIButton *)sender{
    
    UIView *view = [self.view viewWithTag:200];
    // 先缩小
    view.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        // 放大
        view.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    SettingViewController *aVc = [[SettingViewController alloc]init];
    [self presentViewController:aVc animated:YES completion:nil];
}
- (void)createSelectedButton{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    image.center = self.view.center;
    image.image = [UIImage imageNamed:@"ImagYuan"];
//    [self.view addSubview:image];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view1.center = self.view.center;
    view1.layer.cornerRadius = 50;
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    view1.tag = 100;
  
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    view2.center = self.view.center;
    view2.layer.cornerRadius = 50;
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    view2.tag = 101;
    
    view1.alpha = 0;
    view2.alpha = 0;
   
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:button];
    button.center = self.view.center;
    [button addTarget:self action:@selector(selectedXiangCeImage) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateHighlighted];
    //    button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:@selector(TouchDown)forControlEvents: UIControlEventTouchDown];
    button.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
      
        button.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            
            view1.alpha = 1;
            view2.alpha = 1;
            
            view2.frame = CGRectMake(0, 0, 98, 98);
            view2.center = self.view.center;
            view2.layer.cornerRadius = 49;
            
            view2.layer.shadowOffset = CGSizeMake(-3, -3);
            view2.layer.shadowColor = [UIColor whiteColor].CGColor;
            view2.layer.shadowOpacity=0.5f;
            view2.layer.shadowRadius= 10;
            
            view1.layer.shadowOffset = CGSizeMake(3, 3);
            view1.layer.shadowColor = [UIColor whiteColor].CGColor;
            view1.layer.shadowOpacity=0.5f;
            view1.layer.shadowRadius= 10;
        }];
    }];
    
 
    
    
 

}

- (void)TouchDown{

}

- (void)selectedXiangCeImage{
    [self kaiShiZhenDong];
    
    UIView *view1 = [self.view viewWithTag:100];
    UIView *view2 = [self.view viewWithTag:100];

    // 先缩小
    view1.transform = CGAffineTransformMakeScale(0.8, 0.8);
    view2.transform = CGAffineTransformMakeScale(0.8, 0.8);

    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:13 initialSpringVelocity:1 options:0 animations:^{
        // 放大
        view1.transform = CGAffineTransformMakeScale(1, 1);
        view2.transform = CGAffineTransformMakeScale(1, 1);

    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //初始化UIImagePickerController类
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        //判断数据来源为相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置代理
        picker.delegate = self;
        //打开相册
        [self presentViewController:picker animated:YES completion:nil];
    });
   
}

#pragma mark =============代理===========
//选择完成回调函数
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
     //获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
   
     self.selectedImage = image;
     
     [self createBeiJing];
     [self createImageViewToShow];
     
     NSString *styleString =  [[NSUserDefaults standardUserDefaults]objectForKey:@"STYLE"];
     
     if ([styleString isEqualToString:@"4"]) {
         [self cutSiGongGeForYou];
     }else{
         [self cutImageForYou];
     }
 }

 //用户取消选择
 - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
 [self dismissViewControllerAnimated:YES completion:nil];
 }


- (void)createBeiJing{
    
//    self.selectedImage =  [UIImage imageNamed:@"样本.jpg"];
    
    self.backGroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backGroundImageView];
    self.backGroundImageView.image = self.selectedImage;
    
    
    self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:self.effect];
    self.effectView.frame = self.backGroundImageView.bounds;
    self.effectView.alpha = 1.f;
    self.effectView.userInteractionEnabled = YES;
    [_backGroundImageView addSubview:self.effectView];

}
- (void)createImageViewToShow{
    
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
//    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.center = self.view.center;
    self.mainScrollView.backgroundColor = [UIColor redColor];
    self.mainScrollView.showsVerticalScrollIndicator=NO;
    self.mainScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenWidth);

    
//    CALayer *subLayer=[CALayer layer];
//    CGRect fixframe=_mainScrollView.layer.frame;
//    subLayer.frame = fixframe;
//    self.mainScrollView.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
//    subLayer.masksToBounds=NO;

    
 
    
    self.yuanTuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    self.yuanTuImageView.center = self.view.center;
    [self.view addSubview:self.yuanTuImageView];
    self.yuanTuImageView.image =self.selectedImage;
    self.yuanTuImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.yuanTuImageView.clipsToBounds = YES;
    
    self.yuanTuImageView.layer.shadowColor=[UIColor grayColor].CGColor;
    self.yuanTuImageView.layer.shadowOffset=CGSizeMake(0,5);
    self.yuanTuImageView.layer.shadowOpacity=0.5f;
    self.yuanTuImageView.layer.shadowRadius= 5;
    
    
    
    UIButton *getDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getDownButton.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(60), ScreenHeight - kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    getDownButton.backgroundColor = [UIColor clearColor];
//    getDownButton.layer.masksToBounds = YES;
//    getDownButton.layer.cornerRadius = 25;
//    [button setTitle:@"裁剪" forState:UIControlStateNormal];
    [getDownButton addTarget:self action:@selector(saveImagesToXiangCe) forControlEvents:UIControlEventTouchUpInside];
    [getDownButton setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [getDownButton setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateHighlighted];
    getDownButton.tag = 105;
    [self.view addSubview:getDownButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(110), ScreenHeight - kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    backButton.backgroundColor = [UIColor clearColor];
//    backButton.layer.masksToBounds = YES;
//    backButton.layer.cornerRadius = 25;
    //    [button setTitle:@"裁剪" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToStart) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
    backButton.tag = 106;
    [self.view addSubview:backButton];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(160), ScreenHeight - kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    shareButton.backgroundColor = [UIColor clearColor];
    //    backButton.layer.masksToBounds = YES;
    //    backButton.layer.cornerRadius = 25;
    //    [button setTitle:@"裁剪" forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"分享2"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"分享2"] forState:UIControlStateHighlighted];
    shareButton.tag = 107;
    [self.view addSubview:shareButton];
    
     _jiuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _jiuBtn.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(60), kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    _jiuBtn.backgroundColor = [UIColor clearColor];
    [_jiuBtn addTarget:self action:@selector(change9Image:) forControlEvents:UIControlEventTouchUpInside];
    [_jiuBtn setImage:[UIImage imageNamed:@"九宫格白.png"] forState:UIControlStateNormal];
    [_jiuBtn setImage:[UIImage imageNamed:@"九宫格.png"] forState:UIControlStateSelected];
    _jiuBtn.layer.shadowRadius = 8;
    _jiuBtn.layer.shadowOffset = CGSizeMake(2, 5);
    _jiuBtn.layer.shadowColor =[UIColor grayColor].CGColor;
    _jiuBtn.layer.shadowOpacity =0.7;
    
    [self.view addSubview:_jiuBtn];
    
    _siBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _siBtn.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(105), kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    _siBtn.backgroundColor = [UIColor clearColor];
    [_siBtn addTarget:self action:@selector(change4Image:) forControlEvents:UIControlEventTouchUpInside];
    [_siBtn setImage:[UIImage imageNamed:@"四宫格 (3).png"] forState:UIControlStateNormal];
    [_siBtn setImage:[UIImage imageNamed:@"四宫格 (2).png"] forState:UIControlStateSelected];
    [self.view addSubview:_siBtn];
    _siBtn.layer.shadowRadius = 8;
    _siBtn.layer.shadowOffset = CGSizeMake(2, 5);
    _siBtn.layer.shadowColor =[UIColor grayColor].CGColor;
    _siBtn.layer.shadowOpacity =0.7;
    
    
    NSString *styleString =  [[NSUserDefaults standardUserDefaults]objectForKey:@"STYLE"];
    
    if ([styleString isEqualToString:@"4"]) {
        _siBtn.selected = YES;
        [self cutImageIsJiaXIangSiGongGe];
    }else{
        _jiuBtn.selected = YES;
        [self cutImageIsAJiaXiang];
    }
    
    
    
    self.getDownBtnView = [[UIView alloc]initWithFrame: CGRectMake(ScreenWidth - kAUTOWIDTH(60), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.getDownBtnView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.getDownBtnView];
   
    self.backBtnView = [[UIView alloc]initWithFrame:  CGRectMake(ScreenWidth - kAUTOWIDTH(110), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.backBtnView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.backBtnView];
    
    self.shareBtnView = [[UIView alloc]initWithFrame:  CGRectMake(ScreenWidth - kAUTOWIDTH(160), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.shareBtnView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.shareBtnView];
    
    
    
    
    
    
    UIInterpolatingMotionEffect * backEffX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];// type表示沿水平方向运行效果
    backEffX.maximumRelativeValue = @(-10);
    backEffX.minimumRelativeValue = @(10);
    
    UIInterpolatingMotionEffect * backEffY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];// type表示沿水平方向运行效果
    backEffY.maximumRelativeValue = @(-10);
    backEffY.minimumRelativeValue = @(10);
    
    [self.yuanTuImageView addMotionEffect:backEffX];
    [self.yuanTuImageView addMotionEffect:backEffY];
    
}

-(void)change4Image:(UIButton *)sender{
    sender.selected = YES;
    if (sender.selected) {
        self.jiuBtn.selected = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:@"STYLE"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self cutImageIsJiaXIangSiGongGe];
        [self cutSiGongGeForYou];
    }

}

-(void)change9Image:(UIButton *)sender{
    sender.selected = YES;
    if (sender.selected) {
        self.siBtn.selected = NO;
    [[NSUserDefaults standardUserDefaults] setObject:@"9" forKey:@"STYLE"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self cutImageIsAJiaXiang];
        [self cutImageForYou];
        
    }
}


- (void)shareImage{
    NSArray *activityItems = self.imageArray.mutableCopy;
    if (activityItems.count > 0) {
        
    
    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        activityViewController.popoverPresentationController.sourceView = self.view;

        [self presentViewController:activityViewController animated:YES completion:nil];
    // 分享类型
    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        // 显示选中的分享类型
        NSLog(@"当前选择分享平台 %@",activityType);
        if (completed) {
            ZJViewShow * showEndView =  [[ZJViewShow alloc]initWithFrame:self.view.frame WithTitleString:NSLocalizedString( @"分享成功", nil) WithIamgeName:@"c122"];
            [self.view addSubview:showEndView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [showEndView removeFromSuperview];
            });
            [self backToStart];
            NSLog(@"分享成功");
        }else {
            NSLog(@"分享失败");
//            [self backToStart];
        }
        
    }];
        
    }else{
        
    }
    
}

- (void)backToStart{
    [UIView animateWithDuration:1 animations:^{
        self.yuanTuImageView.alpha = 0;
        self.backGroundImageView.alpha = 0;
        UIButton *button = [self.view viewWithTag:105];
        button.alpha = 0;
        UIButton *button1 = [self.view viewWithTag:106];
        button1.alpha = 0;
        UIButton *button2 = [self.view viewWithTag:107];
        button2.alpha = 0;
        
        self.getDownBtnView.alpha = 0;
        self.backBtnView.alpha = 0;
        self.jiuBtn.alpha = 0;
        self.siBtn.alpha = 0;
    }completion:^(BOOL finished) {
        [self.yuanTuImageView removeFromSuperview];
        [self.backGroundImageView removeFromSuperview];
        UIButton *button = [self.view viewWithTag:105];
        [button removeFromSuperview];
        UIButton *button1 = [self.view viewWithTag:106];
        [button1 removeFromSuperview];
        UIButton *button2 = [self.view viewWithTag:107];
        [button2 removeFromSuperview];
        [self.getDownBtnView removeFromSuperview];
        [self.backBtnView removeFromSuperview];
        [self.jiuBtn removeFromSuperview];
        [self.siBtn removeFromSuperview];
    }];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstText"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstText"];
        //第一次启动
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showAppStoreReView];
        });
    }else{
        //不是第一次启动了
    }
}
- (void)showAppStoreReView{
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    
    //仅支持iOS10.3+（需要做校验） 且每个APP内每年最多弹出3次评分alart
    
    if ([systemVersion doubleValue] > 10.3) {
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
            //防止键盘遮挡
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [SKStoreReviewController requestReview];
        }
    }
    
    
}

- (void)cutImageIsJiaXIangSiGongGe{
   
    for (int i = 0; i < 8; i ++) {
        UIView *view = [self.yuanTuImageView viewWithTag:1000 +i];
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < 6; i ++) {
        UIView *view = [self.yuanTuImageView viewWithTag:10000 +i];
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    // 设置背景的运动效果 ===== BEGIN =====
    UIInterpolatingMotionEffect * backEffX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];// type表示沿水平方向运行效果
    backEffX.maximumRelativeValue = @(25);
    backEffX.minimumRelativeValue = @(-25);
    
    UIInterpolatingMotionEffect * backEffY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];// type表示沿水平方向运行效果
    backEffY.maximumRelativeValue = @(25);
    backEffY.minimumRelativeValue = @(-25);
    //
    //    [self.yuanTuImageView addMotionEffect:backEffX];
    //    [self.yuanTuImageView addMotionEffect:backEffY];
    
    
    for (int i = 0; i < 6; i ++ ) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.yuanTuImageView addSubview:view];
        view.tag = 10000 + i;
        if (i == 0 || i == 1 ) {
            [view addMotionEffect:backEffX];
            [view addMotionEffect:backEffY];
        }
        
        
        if (i == 0 ) {
            view.frame = CGRectMake(ScreenWidth/2 - 2.5, -25, 5, ScreenWidth + 50);
        }
        if (i == 1) {
            view.frame = CGRectMake(-25,ScreenWidth/2  - 2.5 , ScreenWidth + 50,5 );
        }
        if (i == 2) {
            view.frame = CGRectMake(0, 0, ScreenWidth, 5);
        }
        if (i == 3) {
            view.frame = CGRectMake(0, 0, 5,ScreenWidth);
        }
        if (i == 4){
            view.frame = CGRectMake(0, ScreenWidth - 5, ScreenWidth, 5);
        }
        if (i == 5) {
            view.frame = CGRectMake(ScreenWidth - 5, 0, 5,ScreenWidth);
        }
    }
}

#pragma  mark =========创建格子View ============
- (void)cutImageIsAJiaXiang{
    
    for (int i = 0; i < 6; i ++) {
        UIView *view = [self.yuanTuImageView viewWithTag:10000 +i];
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    for (int i = 0; i < 8; i ++) {
        UIView *view = [self.yuanTuImageView viewWithTag:1000 +i];
        if (view) {
            [view removeFromSuperview];
        }
    }
    // 设置背景的运动效果 ===== BEGIN =====
    UIInterpolatingMotionEffect * backEffX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];// type表示沿水平方向运行效果
    backEffX.maximumRelativeValue = @(25);
    backEffX.minimumRelativeValue = @(-25);
    
    UIInterpolatingMotionEffect * backEffY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];// type表示沿水平方向运行效果
    backEffY.maximumRelativeValue = @(25);
    backEffY.minimumRelativeValue = @(-25);
//
//    [self.yuanTuImageView addMotionEffect:backEffX];
//    [self.yuanTuImageView addMotionEffect:backEffY];
    
   
    for (int i = 0; i < 8; i ++ ) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.yuanTuImageView addSubview:view];
        view.tag = 1000 + i;
        if (i == 0 || i == 1 || i == 2 || i ==3) {
            [view addMotionEffect:backEffX];
            [view addMotionEffect:backEffY];
        }
     
        
        if (i == 0 || i == 1) {
            view.frame = CGRectMake(ScreenWidth/3 + ScreenWidth/3 *i, -25, 5, ScreenWidth + 50);
        }
        if (i == 2 || i == 3) {
            view.frame = CGRectMake(-25,ScreenWidth/3 + ScreenWidth/3 *(i-2), ScreenWidth + 50,5 );
        }
        if (i == 4) {
            view.frame = CGRectMake(0, 0, ScreenWidth, 5);
        }
        if (i == 5) {
            view.frame = CGRectMake(0, 0, 5,ScreenWidth);
        }
        if (i == 6){
            view.frame = CGRectMake(0, ScreenWidth - 5, ScreenWidth, 5);
        }
        if (i == 7) {
            view.frame = CGRectMake(ScreenWidth - 5, 0, 5,ScreenWidth);
        }
    }
}


- (void)cutSiGongGeForYou{
    [self.imageArray removeAllObjects];
    UIImage *image = self.selectedImage;
    CGFloat fixelW = CGImageGetWidth(image.CGImage);
    CGFloat fixelH = CGImageGetHeight(image.CGImage);
    CGFloat cutFloat = 0;
    UIImage *newReadyCutImage = [[UIImage alloc]init];
    if (fixelW > fixelH) {
        newReadyCutImage = [ViewController imageFromImage:image inRect:CGRectMake((fixelW - fixelH)/2, 0, fixelH, fixelH)];
        cutFloat = fixelH;
    }
    if (fixelH > fixelW) {
        newReadyCutImage = [ViewController imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;
        
    }
    if (fixelH == fixelW) {
        newReadyCutImage = [ViewController imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;
        
    }
    
    CGFloat fixelWnew = CGImageGetWidth(newReadyCutImage.CGImage);
    CGFloat fixelHnew = CGImageGetHeight(newReadyCutImage.CGImage);
    NSLog(@"%lf======%lf",fixelHnew,fixelWnew);
    for (int i = 0; i < 4; i ++ ) {
        
        UIImage *saveImage = [[UIImage alloc]init];
        if (i == 0 || i ==1 ) {
            saveImage = [ViewController imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/2*i,0 , cutFloat/2, cutFloat/2)];
        }
        if (i == 2 || i ==3) {
            saveImage = [ViewController imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/2*(i-2),cutFloat/2, cutFloat/2, cutFloat/2)];
        }
        [self.imageArray addObject:saveImage];
    }
}

- (void)cutImageForYou{
    [self.imageArray removeAllObjects];
    UIImage *image = self.selectedImage;
    CGFloat fixelW = CGImageGetWidth(image.CGImage);
    CGFloat fixelH = CGImageGetHeight(image.CGImage);
    CGFloat cutFloat = 0;
    UIImage *newReadyCutImage = [[UIImage alloc]init];
    if (fixelW > fixelH) {
       newReadyCutImage = [ViewController imageFromImage:image inRect:CGRectMake((fixelW - fixelH)/2, 0, fixelH, fixelH)];
        cutFloat = fixelH;
    }
    if (fixelH > fixelW) {
        newReadyCutImage = [ViewController imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;

    }
    if (fixelH == fixelW) {
        newReadyCutImage = [ViewController imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;
        
    }
    
    CGFloat fixelWnew = CGImageGetWidth(newReadyCutImage.CGImage);
    CGFloat fixelHnew = CGImageGetHeight(newReadyCutImage.CGImage);
    NSLog(@"%lf======%lf",fixelHnew,fixelWnew);
    for (int i = 0; i < 9; i ++ ) {
        
        UIImage *saveImage = [[UIImage alloc]init];
        if (i == 0 || i ==1 || i ==2) {
             saveImage = [ViewController imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/3*i,0 , cutFloat/3, cutFloat/3)];
        }
        if (i == 3 || i ==4 || i ==5) {
             saveImage = [ViewController imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/3*(i-3),cutFloat/3, cutFloat/3, cutFloat/3)];
        }
        if (i == 6 || i ==7 || i ==8) {
             saveImage = [ViewController imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/3*(i-6),cutFloat/3 * 2, cutFloat/3, cutFloat/3)];
        }
        [self.imageArray addObject:saveImage];
    }

}


- (void) writeImages:(NSMutableArray*)images
        completion:(completion_t)completionHandler {
        if ([images count] == 0) {
                 if (completionHandler) {
                      // Signal completion to the call-site. Use an appropriate result,
                        // instead of @"finished" possibly pass an array of URLs and NSErrors
                        // generated below  in "handle URL or error".
                        completionHandler(@"images are all saved.");
                     }
                 return;
             }
        UIImage* image = [images firstObject];
        [self.assetsLibrary writeImageToSavedPhotosAlbum:image.CGImage
                                             orientation:ALAssetOrientationUp
                                         completionBlock:^(NSURL *assetURL, NSError *error){
                         // Caution: check the execution context - it may be any thread,
                        // possibly use dispatch_async to dispatch to the main thread or
                         // any other queue.
                       // handle URL or error
                        if (error) {
                                  NSLog(@"error = %@", [error localizedDescription]);
                                  _isImagesSavedFailed = true;
                                  return;
                              }
                         [images removeObjectAtIndex:0];
                          // next image:
                          [self writeImages:images completion:completionHandler];
                      }];
     }

- (void)saveImagesToXiangCe{
    
    ZJViewShow * showbeginView = [[ZJViewShow alloc]initWithFrame:self.view.frame WithTitleString:NSLocalizedString(@"保存中......" , nil) WithIamgeName:@"c11"];
    [self.view addSubview:showbeginView];
    
    [self writeImages:self.imageArray completion:^(id result) {
             NSLog(@"Result: %@", result);
//             [hud stopLoading];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [showbeginView removeFromSuperview];
        });
        
        ZJViewShow * showEndView =  [[ZJViewShow alloc]initWithFrame:self.view.frame WithTitleString:NSLocalizedString( @"保存成功", nil) WithIamgeName:@"c122"];
        [self.view addSubview:showEndView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [showEndView removeFromSuperview];
            [self backToStart];
        
        });
              if (_isImagesSavedFailed) {
                        //handle failed.
                   }else{
                            //handle success.
                         }
         }];
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
