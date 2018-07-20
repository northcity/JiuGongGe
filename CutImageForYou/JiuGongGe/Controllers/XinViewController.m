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




@interface XinViewController ()
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
    [self presentViewController:x0VC animated:YES completion:nil];
}

- (void)presentXin1ImageViewController{
    XinImage1ViewController *x1VC = [[XinImage1ViewController alloc]init];
    [self presentViewController:x1VC animated:YES completion:nil];
}

- (void)presentXin2ImageViewController{
    XinImage2ViewController *x2VC = [[XinImage2ViewController alloc]init];
    [self presentViewController:x2VC animated:YES completion:nil];
}

- (void)presentXin3ImageViewController{
    XinImage3ViewController *x3VC = [[XinImage3ViewController alloc]init];
    [self presentViewController:x3VC animated:YES completion:nil];
}

- (void)presentXin4ImageViewController{
    XinImage4ViewController *x4VC = [[XinImage4ViewController alloc]init];
    [self presentViewController:x4VC animated:YES completion:nil];
}

- (void)presentXin5ImageViewController{
    XinImage5ViewController *x5VC = [[XinImage5ViewController alloc]init];
    [self presentViewController:x5VC animated:YES completion:nil];
}

- (void)presentXin6ImageViewController{
    XinImage6ViewController *x6VC = [[XinImage6ViewController alloc]init];
    [self presentViewController:x6VC animated:YES completion:nil];
}

- (void)presentXin7ImageViewController{
    XinImage7ViewController *x7VC = [[XinImage7ViewController alloc]init];
    [self presentViewController:x7VC animated:YES completion:nil];
}

- (void)presentXin8ImageViewController{
    XinImage8ViewController *x8VC = [[XinImage8ViewController alloc]init];
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
