//
//  XinViewController.m
//  CutImageForYou
//
//  Created by 北城 on 2018/7/19.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "XinViewController.h"
#import "XinImage0ViewController.h"
#import "XinImage1ViewController.h"
#import "XinImage2ViewController.h"
#import "XinImage3ViewController.h"
#import "XinImage4ViewController.h"
#import "XinImage5ViewController.h"
#import "XinImage8ViewController.h"
#import "XinImage6ViewController.h"
#import "XinImage7ViewController.h"
#import "ZJViewShow.h"



@interface XinViewController (){
    BOOL _isImagesSavedFailed;
}
@property (nonatomic, strong) UIImageView *imageView0;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIImageView *imageView4;
@property (nonatomic, strong) UIImageView *imageView5;
@property (nonatomic, strong) UIImageView *imageView6;
@property (nonatomic, strong) UIImageView *imageView7;
@property (nonatomic, strong) UIImageView *imageView8;
@property (nonatomic, strong) UIImageView *imageView1;

@end

@implementation XinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self init9View];
    self.allImageArray = [NSMutableArray array];
    [self createButton];
}

- (void)createButton{
    self.getDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getDownButton.frame = CGRectMake(ScreenWidth - kAUTOWIDTH(60), ScreenHeight - kAUTOHEIGHT(60), kAUTOWIDTH(25), kAUTOHEIGHT(25));
    [self.getDownButton addTarget:self action:@selector(saveImagesToXiangCe) forControlEvents:UIControlEventTouchUpInside];
    [self.getDownButton setImage:[UIImage imageNamed:@"下载1"] forState:UIControlStateNormal];
    [self.getDownButton setImage:[UIImage imageNamed:@"下载1"] forState:UIControlStateHighlighted];
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
    [self.shareButton setImage:[UIImage imageNamed:@"分享1"] forState:UIControlStateNormal];
    [self.shareButton setImage:[UIImage imageNamed:@"分享1"] forState:UIControlStateHighlighted];
    self.shareButton.tag = 107;
    
    self.getDownBtnView = [[UIView alloc]initWithFrame: CGRectMake(ScreenWidth - kAUTOWIDTH(60), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.getDownBtnView.backgroundColor = [UIColor blackColor];
    
    self.backBtnView = [[UIView alloc]initWithFrame:  CGRectMake(ScreenWidth - kAUTOWIDTH(110), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.backBtnView.backgroundColor = [UIColor blackColor];
    
    self.shareBtnView = [[UIView alloc]initWithFrame:  CGRectMake(ScreenWidth - kAUTOWIDTH(160), ScreenHeight - kAUTOHEIGHT(26), kAUTOWIDTH(25), 1)];
    self.shareBtnView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.getDownButton];
//    [self.view addSubview:self.backButton];
    [self.view addSubview:self.shareButton];
    [self.view addSubview:self.getDownBtnView];
    [self.view addSubview:self.backBtnView];
    [self.view addSubview:self.shareBtnView];
    
}

- (void)saveImagesToXiangCe{
    
    [self.allImageArray removeAllObjects];
    if (self.selectImage0 && self.imageView0 != nil) {
        [self.allImageArray addObject:self.selectImage0];
    }
    if (self.selectImage1 && self.imageView1 != nil) {
        [self.allImageArray addObject:self.selectImage1];
    }
    if (self.selectImage2 && self.imageView2 != nil) {
        [self.allImageArray addObject:self.selectImage2];
    }
    if (self.selectImage3 && self.imageView3 != nil) {
        [self.allImageArray addObject:self.selectImage3];
    }
    if (self.selectImage4 && self.imageView4 != nil) {
        [self.allImageArray addObject:self.selectImage4];
    }
    if (self.selectImage5 && self.imageView5 != nil) {
        [self.allImageArray addObject:self.selectImage5];
    }
    if (self.selectImage6 && self.imageView6 != nil) {
        [self.allImageArray addObject:self.selectImage6];
    }
    if (self.selectImage7 && self.imageView7 != nil) {
        [self.allImageArray addObject:self.selectImage7];
    }
    if (self.selectImage8 && self.selectImage8 != nil) {
        [self.allImageArray addObject:self.selectImage8];
    }

    
    ZJViewShow * showbeginView = [[ZJViewShow alloc]initWithFrame:self.view.frame WithTitleString:NSLocalizedString(@"保存中......" , nil) WithIamgeName:@"c11"];
    [self.view addSubview:showbeginView];
    
    [self writeImages:self.allImageArray completion:^(id result) {
        NSLog(@"Result: %@", result);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [showbeginView removeFromSuperview];
        });
        
        ZJViewShow * showEndView =  [[ZJViewShow alloc]initWithFrame:self.view.frame WithTitleString:NSLocalizedString( @"保存成功", nil) WithIamgeName:@"c122"];
        [self.view addSubview:showEndView];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [showEndView removeFromSuperview];
//            [self backToStart];

        });
        if (_isImagesSavedFailed) {
            //handle failed.
        }else{
            //handle success.
        }
    }];
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

#pragma mark ========= 三大按钮 =========
//分享图片
- (void)shareImage{
    
    [self.allImageArray removeAllObjects];
    [self.allImageArray removeAllObjects];
    if (self.selectImage0 && self.imageView0 != nil) {
        [self.allImageArray addObject:self.selectImage0];
    }
    if (self.selectImage1 && self.imageView1 != nil) {
        [self.allImageArray addObject:self.selectImage1];
    }
    if (self.selectImage2 && self.imageView2 != nil) {
        [self.allImageArray addObject:self.selectImage2];
    }
    if (self.selectImage3 && self.imageView3 != nil) {
        [self.allImageArray addObject:self.selectImage3];
    }
    if (self.selectImage4 && self.imageView4 != nil) {
        [self.allImageArray addObject:self.selectImage4];
    }
    if (self.selectImage5 && self.imageView5 != nil) {
        [self.allImageArray addObject:self.selectImage5];
    }
    if (self.selectImage6 && self.imageView6 != nil) {
        [self.allImageArray addObject:self.selectImage6];
    }
    if (self.selectImage7 && self.imageView7 != nil) {
        [self.allImageArray addObject:self.selectImage7];
    }
    if (self.selectImage8 && self.selectImage8 != nil) {
        [self.allImageArray addObject:self.selectImage8];
    }

    
    NSArray *activityItems = self.allImageArray.mutableCopy;
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
//                [self backToStart];
            }
        }];
    }
}











- (void)init9View{
    self.imageView0 = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2 - IMAGEVIEW_HEIGHT_MAIN * 1.5, IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView0.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView0];
    
   
    
    
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH_MAIN + kAUTOWIDTH(5), ScreenHeight/2 - IMAGEVIEW_HEIGHT_MAIN * 1.5, IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH_MAIN * 2 + kAUTOWIDTH(10), ScreenHeight/2 - IMAGEVIEW_HEIGHT_MAIN * 1.5, IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView2];
    
    self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2 - IMAGEVIEW_HEIGHT_MAIN * 0.5 + kAUTOWIDTH(5), IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView3.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView3];
    
    self.imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH_MAIN  + kAUTOWIDTH(5), ScreenHeight/2 - IMAGEVIEW_HEIGHT_MAIN * 0.5 + kAUTOWIDTH(5), IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView4.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView4];
    
    self.imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH_MAIN * 2 + kAUTOWIDTH(10),  ScreenHeight/2 - IMAGEVIEW_HEIGHT_MAIN * 0.5 + kAUTOWIDTH(5), IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView5.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView5];
    
    self.imageView6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2 + IMAGEVIEW_HEIGHT_MAIN * 0.5 + kAUTOWIDTH(10), IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView6.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView6];
    
    self.imageView7 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH_MAIN  + kAUTOWIDTH(5), ScreenHeight/2 + IMAGEVIEW_HEIGHT_MAIN * 0.5 + kAUTOWIDTH(10), IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView7.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView7];
    
    self.imageView8 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH_MAIN * 2 + kAUTOWIDTH(10),  ScreenHeight/2 + IMAGEVIEW_HEIGHT_MAIN * 0.5 + kAUTOWIDTH(10), IMAGEVIEW_WIDTH_MAIN, IMAGEVIEW_HEIGHT_MAIN)];
    self.imageView8.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView8];
    
    
    self.imageView0.userInteractionEnabled = YES;
    self.imageView1.userInteractionEnabled = YES;
    self.imageView2.userInteractionEnabled = YES;
    self.imageView3.userInteractionEnabled = YES;
    self.imageView4.userInteractionEnabled = YES;
    self.imageView5.userInteractionEnabled = YES;
    self.imageView6.userInteractionEnabled = YES;
    self.imageView7.userInteractionEnabled = YES;
    self.imageView8.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGesture0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin0ImageViewController)];
    [self.imageView0  addGestureRecognizer:tapGesture0];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin1ImageViewController)];
    [self.imageView1  addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin2ImageViewController)];
    [self.imageView2  addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin3ImageViewController)];
    [self.imageView3  addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin4ImageViewController)];
    [self.imageView4  addGestureRecognizer:tapGesture4];
    
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin5ImageViewController)];
    [self.imageView5  addGestureRecognizer:tapGesture5];
    
    UITapGestureRecognizer *tapGesture6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin6ImageViewController)];
    [self.imageView6  addGestureRecognizer:tapGesture6];
    
    UITapGestureRecognizer *tapGesture7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin7ImageViewController)];
    [self.imageView7  addGestureRecognizer:tapGesture7];
    
    UITapGestureRecognizer *tapGesture8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentXin8ImageViewController)];
    [self.imageView8  addGestureRecognizer:tapGesture8];
    

}

- (void)presentXin0ImageViewController{
    XinImage0ViewController *x0VC = [[XinImage0ViewController alloc]init];
    x0VC.imageBlock = ^(UIImage *image) {
        self.imageView0.image  = image;
        self.selectImage0 = image;
    };
    [self presentViewController:x0VC animated:YES completion:nil];
}

- (void)presentXin1ImageViewController{
    XinImage1ViewController *x1VC = [[XinImage1ViewController alloc]init];
    
    x1VC.imageBlock = ^(UIImage *image) {
        self.imageView1.image  = image;        self.selectImage1 = image;

    };
    [self presentViewController:x1VC animated:YES completion:nil];
}

- (void)presentXin2ImageViewController{
    XinImage2ViewController *x2VC = [[XinImage2ViewController alloc]init];
    
    x2VC.imageBlock = ^(UIImage *image) {
        self.imageView2.image  = image;        self.selectImage2 = image;

    };
    [self presentViewController:x2VC animated:YES completion:nil];
}

- (void)presentXin3ImageViewController{
    XinImage3ViewController *x3VC = [[XinImage3ViewController alloc]init];
    
    x3VC.imageBlock = ^(UIImage *image) {
        self.imageView3.image  = image;        self.selectImage3 = image;

    };
    [self presentViewController:x3VC animated:YES completion:nil];
}

- (void)presentXin4ImageViewController{
    XinImage4ViewController *x4VC = [[XinImage4ViewController alloc]init];
    
    x4VC.imageBlock = ^(UIImage *image) {
        self.imageView4.image  = image;        self.selectImage4 = image;

    };
    [self presentViewController:x4VC animated:YES completion:nil];
}

- (void)presentXin5ImageViewController{
    XinImage5ViewController *x5VC = [[XinImage5ViewController alloc]init];
    
    x5VC.imageBlock = ^(UIImage *image) {
        self.imageView5.image  = image;        self.selectImage5 = image;

    };
    [self presentViewController:x5VC animated:YES completion:nil];
}

- (void)presentXin6ImageViewController{
    XinImage6ViewController *x6VC = [[XinImage6ViewController alloc]init];
    
    x6VC.imageBlock = ^(UIImage *image) {
        self.imageView6.image  = image;        self.selectImage6 = image;

    };
    [self presentViewController:x6VC animated:YES completion:nil];
}

- (void)presentXin7ImageViewController{
    XinImage7ViewController *x7VC = [[XinImage7ViewController alloc]init];
    x7VC.imageBlock = ^(UIImage *image) {
        self.imageView7.image  = image;        self.selectImage7 = image;

    };
    [self presentViewController:x7VC animated:YES completion:nil];
}

- (void)presentXin8ImageViewController{
    XinImage8ViewController *x8VC = [[XinImage8ViewController alloc]init];
    
    x8VC.imageBlock = ^(UIImage *image) {
        self.imageView8.image  = image;        self.selectImage8 = image;

    };
    [self presentViewController:x8VC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
