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


@end
