//
//  XinImage2ViewController.m
//  CutImageForYou
//
//  Created by 北城 on 2018/7/19.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "XinImage2ViewController.h"

@interface XinImage2ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
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

@implementation XinImage2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self init9View];
}
- (void)init9View{
    self.imageView0 = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2 - IMAGEVIEW_HEIGHT * 1.5, IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView0.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView0];
    
    
    
    
    self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH + kAUTOWIDTH(10), ScreenHeight/2 - IMAGEVIEW_HEIGHT * 1.5, IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView1.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView1];
    
    self.imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH * 2 + kAUTOWIDTH(20), ScreenHeight/2 - IMAGEVIEW_HEIGHT * 1.5, IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView2];
    
    self.imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2 - IMAGEVIEW_HEIGHT * 0.5 + kAUTOWIDTH(10), IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView3.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView3];
    
    self.imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH  + kAUTOWIDTH(10), ScreenHeight/2 - IMAGEVIEW_HEIGHT * 0.5 + kAUTOWIDTH(10), IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView4.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView4];
    
    self.imageView5 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH * 2 + kAUTOWIDTH(20),  ScreenHeight/2 - IMAGEVIEW_HEIGHT * 0.5 + kAUTOWIDTH(10), IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView5.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView5];
    
    self.imageView6 = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2 + IMAGEVIEW_HEIGHT * 0.5 + kAUTOWIDTH(20), IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView6.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView6];
    
    self.imageView7 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH  + kAUTOWIDTH(10), ScreenHeight/2 + IMAGEVIEW_HEIGHT * 0.5 + kAUTOWIDTH(20), IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
    self.imageView7.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView7];
    
    self.imageView8 = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGEVIEW_WIDTH * 2 + kAUTOWIDTH(20),  ScreenHeight/2 + IMAGEVIEW_HEIGHT * 0.5 + kAUTOWIDTH(20), IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
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
    
    self.imageView0.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView1.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView2.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView3.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView4.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView5.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView6.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView7.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView8.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageView0.clipsToBounds = YES;
    self.imageView1.clipsToBounds = YES;
    self.imageView2.clipsToBounds = YES;
    self.imageView3.clipsToBounds = YES;
    self.imageView4.clipsToBounds = YES;
    self.imageView5.clipsToBounds = YES;
    self.imageView6.clipsToBounds = YES;
    self.imageView7.clipsToBounds = YES;
    self.imageView8.clipsToBounds = YES;
    
    
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
    
    self.imageView0.hidden = YES;
    self.imageView1.hidden = YES;
    self.imageView2.hidden = YES;
    self.imageView4.hidden = YES;
    self.imageView5.hidden = YES;
    self.imageView8.hidden = YES;
    
    
    
}


- (void)presentXin0ImageViewController{
    
}

- (void)presentXin1ImageViewController{
}

- (void)presentXin2ImageViewController{
}

- (void)presentXin3ImageViewController{
    //初始化UIImagePickerController类
    self.picker3 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker3.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker3.allowsEditing = YES;
    
    
    //设置代理
    self.picker3.delegate = self;
    //打开相册
    [self presentViewController:self.picker3 animated:YES completion:nil];
}


- (void)presentXin4ImageViewController{
}

- (void)presentXin5ImageViewController{
  
}

- (void)presentXin6ImageViewController{
    //初始化UIImagePickerController类
    self.picker6 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker6.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker6.allowsEditing = YES;
    
    
    //设置代理
    self.picker6.delegate = self;
    //打开相册
    [self presentViewController:self.picker6 animated:YES completion:nil];
}

- (void)presentXin7ImageViewController{
    //初始化UIImagePickerController类
    self.picker7 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker7.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker7.allowsEditing = YES;
    
    
    //设置代理
    self.picker7.delegate = self;
    //打开相册
    [self presentViewController:self.picker7 animated:YES completion:nil];
}

- (void)presentXin8ImageViewController{
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ========== 图片代理回调 ===========
//选择完成回调函数
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取图片
    NSLog(@"%@",info);
    if ([picker isEqual:self.picker3]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView3.image = image;
    }
    if ([picker isEqual:self.picker6]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView6.image = image;
    }
    if ([picker isEqual:self.picker7]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView7.image = image;
    }
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//用户取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backAction{
    
    [self fullScreenshots];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)fullScreenshots{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    float originX = 0;
    float originy =ScreenHeight/2 - IMAGEVIEW_HEIGHT * 1.5;
    float width =ScreenWidth;
    float height =ScreenHeight;
    //你需要的区域起点,宽,高;
    CGRect rect1 =CGRectMake(originX , originy , ScreenWidth , ScreenWidth);
    UIImage * imgeee = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([viewImage CGImage], rect1)];
    UIImageView *snapImg = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 200,200)];
    snapImg.contentMode = UIViewContentModeScaleAspectFill;
    snapImg.backgroundColor = [UIColor redColor];
    snapImg.image = imgeee;
    if (self.imageBlock) {
        self.imageBlock(imgeee);
    }
    //    [self.view addSubview:snapImg];
}

@end
