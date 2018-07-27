//
//  ViewController.m
//  CutImageForYou
//
//  Created by chenxi on 2018/5/11.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "ZJViewShow.h"
#import "ViewController.h"
#import "STPhotoBroswer.h"
#import <CoreMotion/CoreMotion.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SettingViewController.h"
#import "XinViewController.h"


@interface ViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    CGFloat _lastScale;//记录最后一次的图片放大倍数
    BOOL _isImagesSavedFailed;
}
//最后面的ImageView用来显示模糊层
@property(nonatomic,strong)UIImageView * backGroundImageView;
//用来显示切割图片的ImageView
@property(nonatomic,strong)UIImageView *yuanTuImageView;
//本来打算都放到这个上面的
@property(nonatomic,strong)UIScrollView *mainScrollView;
//保存图片用的东西
@property(nonatomic,strong)ALAssetsLibrary *assetsLibrary;
//用于存放切割后的数组
@property(nonatomic,strong)NSMutableArray *imageArray;
//保存所有图片按钮下面的线
@property(nonatomic,strong)UIView *getDownBtnView;
@property(nonatomic,strong)UIView *backBtnView;
@property(nonatomic,strong)UIView *shareBtnView;
//从相册里选择的图像对象
@property(nonatomic,strong)UIImage *selectedImage;
//模糊视图图层
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property(nonatomic,strong)UIBlurEffect *effect;
//九宫格按钮
@property(nonatomic,strong)UIButton *jiuBtn;
//四宫格按钮
@property(nonatomic,strong)UIButton *siBtn;
@property(nonatomic,strong)UIButton *getDownButton;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *shareButton;

@property(nonatomic, strong) UIButton *xinButton;

@end

@implementation ViewController

#pragma mark ==========吃书画视图=========
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewController];
    [self createXinButton];
    
}

#pragma mark - ======开始心跳动画Animation=======
- (void)startHeartAnimation:(CALayer *)layer repeatCount:(CGFloat)repeatCount{
    if (@available(iOS 9.0, *)) {
        CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"transform.scale"];
        springAnimation.mass = 10.0;
        springAnimation.stiffness = 1200;
        springAnimation.damping = 2;
        springAnimation.initialVelocity = 0;
        springAnimation.duration = 10;
        springAnimation.fromValue = [NSNumber numberWithFloat:0.95];
        springAnimation.toValue = [NSNumber numberWithFloat:1];
        springAnimation.repeatCount = repeatCount;
        springAnimation.autoreverses = YES;
        springAnimation.removedOnCompletion = NO;
        springAnimation.fillMode = kCAFillModeForwards;
        springAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [layer addAnimation:springAnimation forKey:@"springAnimation"];
    }
}

- (void)createXinButton{
    self.xinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.xinButton.frame = CGRectMake(0, 0, 60, 60);
    self.xinButton.backgroundColor = [UIColor clearColor];
    [self.xinButton setImage:[UIImage imageNamed:@"心脏"] forState:UIControlStateNormal];
    [self.xinButton addTarget:self action:@selector(presentXinController) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.xinButton];
    [self startHeartAnimation:self.xinButton.layer repeatCount:MAXFLOAT];
}

- (void) presentXinController{
    XinViewController *xVc = [[XinViewController alloc]init];
    [self presentViewController:xVc animated:YES completion:nil];
}

- (void)setViewController{
    self.view.backgroundColor = [UIColor blackColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createAboutBtn];
        [self createSelectedButton];
    });
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
    
    //    关于我按钮
    UIButton *aboutMeButton = [[UIButton alloc]initWithFrame:CGRectMake((ScreenWidth - kAUTOWIDTH(50))/2, ScreenHeight - 100, kAUTOWIDTH(50), kAUTOHEIGHT(50))];
    [aboutMeButton addTarget:self action:@selector(presentAboutMeController:) forControlEvents:UIControlEventTouchUpInside];
    aboutMeButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aboutMeButton];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth - kAUTOWIDTH(50))/2, aboutMeButton.frame.origin.y + kAUTOHEIGHT(50), kAUTOWIDTH(50), 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aboutMeButton];
    [self.view addSubview:lineView];
    lineView.tag = 200;
    if (PNCisIPAD) {
        lineView.frame = CGRectMake((ScreenWidth - kAUTOWIDTH(50))/2, aboutMeButton.frame.origin.y + 50, kAUTOWIDTH(50), 1);
    }
}

//跳转
- (void)presentAboutMeController:(UIButton *)sender{
    SettingViewController *aVc = [[SettingViewController alloc]init];
    [self presentViewController:aVc animated:YES completion:nil];
}

- (void)createSelectedButton{
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.center = self.view.center;
    whiteView.layer.cornerRadius = 50;
    [self.view addSubview:whiteView];
    whiteView.tag = 100;
    whiteView.alpha = 0;
    
    UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.center = self.view.center;
    blackView.layer.cornerRadius = 50;
    [self.view addSubview:blackView];
    blackView.tag = 101;
    blackView.alpha = 0;
    
    UIButton *addImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.view addSubview:addImageButton];
    addImageButton.center = self.view.center;
    [addImageButton addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [addImageButton setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateNormal];
    [addImageButton setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateHighlighted];
    addImageButton.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        addImageButton.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            
            whiteView.layer.shadowColor = [UIColor whiteColor].CGColor;
            whiteView.layer.shadowOffset = CGSizeMake(3, 3);
            whiteView.layer.shadowOpacity=0.5f;
            whiteView.layer.shadowRadius= 10;
            whiteView.alpha = 1;
            
            blackView.layer.shadowColor = [UIColor whiteColor].CGColor;
            blackView.layer.shadowOffset = CGSizeMake(-3, -3);
            blackView.frame = CGRectMake(0, 0, 98, 98);
            blackView.center = self.view.center;
            blackView.layer.cornerRadius = 49;
            blackView.layer.shadowOpacity=0.5f;
            blackView.layer.shadowRadius= 10;
            blackView.alpha = 1;
        }];
    }];
}

- (void)showActionSheet{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"你想干啥？" message:@"切九宫格还是拼心形" preferredStyle:UIAlertControllerStyleActionSheet];
    
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,         取消按钮
     UIAlertActionStyleDestructive     破坏性按钮，比如：“删除”，字体颜色是红色的
     } NS_ENUM_AVAILABLE_IOS(8_0);
     
     */
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"九宫格切图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了按钮1，进入按钮1的事件");
        [self selectedXiangCeImage];
    }];

    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"心形拼图" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self presentXinController];
        //跳到创建alertview的方法，一般在点击删除这里按钮之后，都需要一个提示框，提醒用户是否真的删除
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action3];
    [actionSheet addAction:action2];

    actionSheet.popoverPresentationController.sourceView = self.view;
    actionSheet.popoverPresentationController.sourceRect = CGRectMake(0,0,1.0,1.0);
    
  
    //相当于之前的[actionSheet show];
    [self presentViewController:actionSheet animated:YES completion:nil];

}




#pragma mark  ========== 选择图片 ===========
- (void)selectedXiangCeImage{
    [BCJiuGongGeImageManager maDaKaiShiZhenDong];
    UIView *whiteView = [self.view viewWithTag:100];
    UIView *blackView = [self.view viewWithTag:101];
    
    whiteView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    blackView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    
    [UIView animateWithDuration: 0.7 delay:0 usingSpringWithDamping:13 initialSpringVelocity:1 options:0 animations:^{
        whiteView.transform = CGAffineTransformMakeScale(1, 1);
        blackView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //初始化UIImagePickerController类
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        //判断数据来源为相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置代理
        picker.delegate = self;
        picker.allowsEditing = YES;
        //打开相册
        [self presentViewController:picker animated:YES completion:nil];
    });
}

#pragma mark ========== 图片代理回调 ===========
//选择完成回调函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
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

//创建模糊视图
- (void)createBeiJing{
    _backGroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _backGroundImageView.image = self.selectedImage;
    [self.view addSubview:_backGroundImageView];
    
    self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:self.effect];
    self.effectView.frame = self.backGroundImageView.bounds;
    self.effectView.userInteractionEnabled = YES;
    [_backGroundImageView addSubview:self.effectView];
    self.effectView.alpha = 1.f;
}

#pragma mark ========创建整体视图=========
// 创建要展示的视图
- (void)createImageViewToShow{
    
    self.yuanTuImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    self.yuanTuImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.yuanTuImageView.center = self.view.center;
    [self.view addSubview:self.yuanTuImageView];
    self.yuanTuImageView.image =self.selectedImage;
    self.yuanTuImageView.clipsToBounds = YES;
    
    self.yuanTuImageView.layer.shadowColor=[UIColor grayColor].CGColor;
    self.yuanTuImageView.layer.shadowOffset=CGSizeMake(0,5);
    self.yuanTuImageView.layer.shadowOpacity=0.5f;
    self.yuanTuImageView.layer.shadowRadius= 5;
    
    self.getDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getDownButton.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(60), ScreenHeight - kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    [self.getDownButton addTarget:self action:@selector(saveImagesToXiangCe) forControlEvents:UIControlEventTouchUpInside];
    [self.getDownButton setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [self.getDownButton setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateHighlighted];
    self.getDownButton.backgroundColor = [UIColor clearColor];
    self.getDownButton.tag = 105;
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(110), ScreenHeight - kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.backButton addTarget:self action:@selector(backToStart) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateHighlighted];
    self.backButton.tag = 106;
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(160), ScreenHeight - kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    self.shareButton.backgroundColor = [UIColor clearColor];
    [self.shareButton addTarget:self action:@selector(shareImage) forControlEvents:UIControlEventTouchUpInside];
    [self.shareButton setImage:[UIImage imageNamed:@"分享2"] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"分享2"] forState:UIControlStateHighlighted];
    self.shareButton.tag = 107;
    
    
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
    
    _siBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _siBtn.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(105), kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    _siBtn.backgroundColor = [UIColor clearColor];
    [_siBtn addTarget:self action:@selector(change4Image:) forControlEvents:UIControlEventTouchUpInside];
    [_siBtn setImage:[UIImage imageNamed:@"四宫格 (3).png"] forState:UIControlStateNormal];
    [_siBtn setImage:[UIImage imageNamed:@"四宫格 (2).png"] forState:UIControlStateSelected];
    
    _siBtn.layer.shadowRadius = 8;
    _siBtn.layer.shadowOffset = CGSizeMake(2, 5);
    _siBtn.layer.shadowColor =[UIColor grayColor].CGColor;
    _siBtn.layer.shadowOpacity =0.7;
    
    NSString *styleString =  [[NSUserDefaults standardUserDefaults]objectForKey:@"STYLE"];
    if ([styleString isEqualToString:@"4"]) {
        _siBtn.selected = YES;
        [self cutImageIsJiaXiangSiGongGe];
    }else{
        _jiuBtn.selected = YES;
        [self cutImageIsAJiaXiang];
    }
    
    self.getDownBtnView = [[UIView alloc]initWithFrame: CGRectMake(ScreenWidth - kAUTOWIDTH(60), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.getDownBtnView.backgroundColor = [UIColor blackColor];
    
    self.backBtnView = [[UIView alloc]initWithFrame:  CGRectMake(ScreenWidth - kAUTOWIDTH(110), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.backBtnView.backgroundColor = [UIColor blackColor];
    
    self.shareBtnView = [[UIView alloc]initWithFrame:  CGRectMake(ScreenWidth - kAUTOWIDTH(160), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.shareBtnView.backgroundColor = [UIColor blackColor];
    
    UIInterpolatingMotionEffect * backEffX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];// type表示沿水平方向运行效果
    backEffX.maximumRelativeValue = @(-10);
    backEffX.minimumRelativeValue = @(10);
    
    UIInterpolatingMotionEffect * backEffY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];// type表示沿水平方向运行效果
    backEffY.maximumRelativeValue = @(-10);
    backEffY.minimumRelativeValue = @(10);
    
    [self.yuanTuImageView addMotionEffect:backEffX];
    [self.yuanTuImageView addMotionEffect:backEffY];
    
    [self.view addSubview:self.getDownButton];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.shareButton];
    [self.view addSubview:self.getDownBtnView];
    [self.view addSubview:self.backBtnView];
    [self.view addSubview:self.shareBtnView];
    [self.view addSubview:self.jiuBtn];
    [self.view addSubview:self.siBtn];
}

#pragma mark ==========切换四宫格===========
-(void)change4Image:(UIButton *)sender{
    sender.selected = YES;
    if (sender.selected) {
        self.jiuBtn.selected = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"4" forKey:@"STYLE"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self cutImageIsJiaXiangSiGongGe];
        [self cutSiGongGeForYou];
    }
}

#pragma mark ==========切换九宫格===========
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

#pragma mark ========= 三大按钮 =========
//分享图片
- (void)shareImage{
    NSArray *activityItems = self.imageArray.mutableCopy;
    if (activityItems.count > 0) {
        UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        //        防止崩溃
        activityViewController.popoverPresentationController.sourceView = self.view;
        [self presentViewController:activityViewController animated:YES completion:nil];
        // 分享类型
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            if (completed) {
                ZJViewShow * showEndView =  [[ZJViewShow alloc]initWithFrame:self.view.frame WithTitleString:NSLocalizedString( @"分享成功", nil) WithIamgeName:@"c122"];
                [self.view addSubview:showEndView];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [showEndView removeFromSuperview];
                });
                [self backToStart];
            }
        }];
    }
}

- (void)backToStart{
    [UIView animateWithDuration:1 animations:^{
        self.yuanTuImageView.alpha = 0;
        self.backGroundImageView.alpha = 0;
        self.getDownButton.alpha = 0;
        self.shareButton.alpha = 0;
        self.backButton.alpha = 0;
        self.getDownBtnView.alpha = 0;
        self.backBtnView.alpha = 0;
        self.jiuBtn.alpha = 0;
        self.siBtn.alpha = 0;
    }completion:^(BOOL finished) {
        [self.yuanTuImageView removeFromSuperview];
        [self.backGroundImageView removeFromSuperview];
        [self.getDownButton removeFromSuperview];
        [self.backButton removeFromSuperview];
        [self.shareButton removeFromSuperview];
        [self.getDownBtnView removeFromSuperview];
        [self.backBtnView removeFromSuperview];
        [self.jiuBtn removeFromSuperview];
        [self.siBtn removeFromSuperview];
    }];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstText"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstText"];
        //第一次启动
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [BCJiuGongGeImageManager showAppStoreReView];
        });
    }
}


- (void)saveImagesToXiangCe{
    
    ZJViewShow * showbeginView = [[ZJViewShow alloc]initWithFrame:self.view.frame WithTitleString:NSLocalizedString(@"保存中......" , nil) WithIamgeName:@"c11"];
    [self.view addSubview:showbeginView];
    
    [self writeImages:self.imageArray completion:^(id result) {
        NSLog(@"Result: %@", result);
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

#pragma  mark =========创建格子View ============
//移除先前的白色分割View
- (void)removeLasterLineView{
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
}
//添加白色的分割View，其实并没有切割·
- (void)cutImageIsJiaXiangSiGongGe{
    [self removeLasterLineView];
    // 设置背景的运动效果 ===== BEGIN =====
    UIInterpolatingMotionEffect * backEffX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];// type表示沿水平方向运行效果
    backEffX.maximumRelativeValue = @(25);
    backEffX.minimumRelativeValue = @(-25);
    
    UIInterpolatingMotionEffect * backEffY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];// type表示沿水平方向运行效果
    backEffY.maximumRelativeValue = @(25);
    backEffY.minimumRelativeValue = @(-25);
    
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

- (void)cutImageIsAJiaXiang{
    [self removeLasterLineView];
    // 设置背景的运动效果 ===== BEGIN =====
    UIInterpolatingMotionEffect * backEffX = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];// type表示沿水平方向运行效果
    backEffX.maximumRelativeValue = @(25);
    backEffX.minimumRelativeValue = @(-25);
    
    UIInterpolatingMotionEffect * backEffY = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];// type表示沿水平方向运行效果
    backEffY.maximumRelativeValue = @(25);
    backEffY.minimumRelativeValue = @(-25);
    
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

#pragma mark =========真正切割图片==========
- (void)cutSiGongGeForYou{
    [self.imageArray removeAllObjects];
    UIImage *image = self.selectedImage;
    CGFloat fixelW = CGImageGetWidth(image.CGImage);
    CGFloat fixelH = CGImageGetHeight(image.CGImage);
    CGFloat cutFloat = 0;
    UIImage *newReadyCutImage = [[UIImage alloc]init];
    if (fixelW > fixelH) {
        newReadyCutImage = [BCJiuGongGeImageManager imageFromImage:image inRect:CGRectMake((fixelW - fixelH)/2, 0, fixelH, fixelH)];
        cutFloat = fixelH;
    }
    if (fixelH > fixelW) {
        newReadyCutImage = [BCJiuGongGeImageManager imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;
    }
    if (fixelH == fixelW) {
        newReadyCutImage = [BCJiuGongGeImageManager imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;
    }
    
    //    CGFloat fixelWnew = CGImageGetWidth(newReadyCutImage.CGImage);
    //    CGFloat fixelHnew = CGImageGetHeight(newReadyCutImage.CGImage);
    
    for (int i = 0; i < 4; i ++ ) {
        UIImage *saveImage = [[UIImage alloc]init];
        if (i == 0 || i ==1 ) {
            saveImage = [BCJiuGongGeImageManager imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/2*i,0 , cutFloat/2, cutFloat/2)];
        }
        if (i == 2 || i ==3) {
            saveImage = [BCJiuGongGeImageManager imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/2*(i-2),cutFloat/2, cutFloat/2, cutFloat/2)];
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
        newReadyCutImage = [BCJiuGongGeImageManager imageFromImage:image inRect:CGRectMake((fixelW - fixelH)/2, 0, fixelH, fixelH)];
        cutFloat = fixelH;
    }
    if (fixelH > fixelW) {
        newReadyCutImage = [BCJiuGongGeImageManager imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;
        
    }
    if (fixelH == fixelW) {
        newReadyCutImage = [BCJiuGongGeImageManager imageFromImage:image inRect:CGRectMake(0, (fixelH - fixelW)/2, fixelW, fixelW)];
        cutFloat = fixelW;
    }
    
    for (int i = 0; i < 9; i ++ ) {
        UIImage *saveImage = [[UIImage alloc]init];
        if (i == 0 || i ==1 || i ==2) {
            saveImage = [BCJiuGongGeImageManager imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/3*i,0 , cutFloat/3, cutFloat/3)];
        }
        if (i == 3 || i ==4 || i ==5) {
            saveImage = [BCJiuGongGeImageManager imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/3*(i-3),cutFloat/3, cutFloat/3, cutFloat/3)];
        }
        if (i == 6 || i ==7 || i ==8) {
            saveImage = [BCJiuGongGeImageManager imageFromImage:newReadyCutImage inRect:CGRectMake(cutFloat/3*(i-6),cutFloat/3 * 2, cutFloat/3, cutFloat/3)];
        }
        [self.imageArray addObject:saveImage];
    }
}

//递归保存图片到本地
- (void) writeImages:(NSMutableArray*)images completion:(completion_t)completionHandler {
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


@end

