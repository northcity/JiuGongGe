//
//  XinImage7ViewController.m
//  CutImageForYou
//
//  Created by 北城 on 2018/7/19.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "XinImage7ViewController.h"

@interface XinImage7ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
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

@implementation XinImage7ViewController


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
    

    self.imageView8.hidden = YES;
    self.imageView6.hidden = YES;
    
}


- (void)presentXin0ImageViewController{
    //初始化UIImagePickerController类
    self.picker0 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker0.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker0.allowsEditing = YES;
    
    
    //设置代理
    self.picker0.delegate = self;
    //打开相册
    [self presentViewController:self.picker0 animated:YES completion:nil];
}

- (void)presentXin1ImageViewController{
    //初始化UIImagePickerController类
    self.picker1 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker1.allowsEditing = YES;
    
    
    //设置代理
    self.picker1.delegate = self;
    //打开相册
    [self presentViewController:self.picker1 animated:YES completion:nil];
}

- (void)presentXin2ImageViewController{
    //初始化UIImagePickerController类
    self.picker2 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker2.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker2.allowsEditing = YES;
    
    
    //设置代理
    self.picker2.delegate = self;
    //打开相册
    [self presentViewController:self.picker2 animated:YES completion:nil];
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
    //初始化UIImagePickerController类
    self.picker4 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker4.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker4.allowsEditing = YES;
    
    
    //设置代理
    self.picker4.delegate = self;
    //打开相册
    [self presentViewController:self.picker4 animated:YES completion:nil];
}

- (void)presentXin5ImageViewController{
    //初始化UIImagePickerController类
    self.picker5 = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    self.picker5.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker5.allowsEditing = YES;
    
    
    //设置代理
    self.picker5.delegate = self;
    //打开相册
    [self presentViewController:self.picker5 animated:YES completion:nil];
}

- (void)presentXin6ImageViewController{
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
    
    if ([picker isEqual:self.picker0]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView0.image = image;
    }
    if ([picker isEqual:self.picker1]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView1.image = image;
    }
    if ([picker isEqual:self.picker2]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView2.image = image;
    }
    if ([picker isEqual:self.picker3]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView3.image = image;
    }
    if ([picker isEqual:self.picker4]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView4.image = image;
    }
    if ([picker isEqual:self.picker5]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.imageViewArray addObject:image];
        self.imageView5.image = image;
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

@end
