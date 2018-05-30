//
//  LaunchViewController.m
//  shijianjiaonang
//
//  Created by chenxi on 2018/3/23.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "LaunchViewController.h"

#import "ViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createImageView];
    self.navigationController.navigationBar.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ViewController *lvc = [[ViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];
    });
}

- (void)createImageView{
    
//    UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2 - 40,ScreenHeight - 150, 80, 80)];
//    [self.view addSubview:iconImage];
//    iconImage.center = self.view.center;
//    iconImage.image = [UIImage imageNamed:@""];
//    iconImage.layer.cornerRadius = kAUTOHEIGHT(8);
//    //        iconImage.layer.borderWidth = 0.5f;
//    //        iconImage.layer.borderColor = [UIColor grayColor].CGColor;
//    iconImage.layer.masksToBounds = YES;
//    CALayer *subLayer=[CALayer layer];
//    CGRect fixframe=iconImage.layer.frame;
//    subLayer.frame = fixframe;
//    subLayer.cornerRadius = kAUTOHEIGHT(8);
//    subLayer.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
//    subLayer.masksToBounds=NO;
//    subLayer.shadowColor=[UIColor grayColor].CGColor;
//    subLayer.shadowOffset=CGSizeMake(0,5);
//    subLayer.shadowOpacity=0.5f;
//    subLayer.shadowRadius= 4;
//    [self.view.layer insertSublayer:subLayer below:iconImage.layer];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:2 animations:^{
////            iconImage.alpha = 0;
////            subLayer.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0].CGColor;
//        }];
//    });
//
    UILabel * label = [Factory createLabelWithTitle:@"Create BY NorthCity" frame:CGRectMake(30, ScreenHeight - kAUTOHEIGHT(74), ScreenWidth - 60, 44)];
    [self.view addSubview:label];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Heiti SC" size:10.f];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            label.textColor = [UIColor whiteColor];
            self.view.backgroundColor = [UIColor blackColor];
        }];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            label.textColor = [UIColor clearColor];
        }];
    });
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
