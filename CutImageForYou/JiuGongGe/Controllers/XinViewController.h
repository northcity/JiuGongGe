//
//  XinViewController.h
//  CutImageForYou
//
//  Created by 北城 on 2018/7/19.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XinBaseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^completion_t)(id result);

@interface XinViewController : XinBaseViewController

@property(nonatomic, strong)NSMutableArray *allImageArray;
//保存图片用的东西
@property(nonatomic,strong)ALAssetsLibrary *assetsLibrary;

@property(nonatomic ,strong)UIImage * selectImage0;
@property(nonatomic ,strong)UIImage * selectImage1;
@property(nonatomic ,strong)UIImage * selectImage2;
@property(nonatomic ,strong)UIImage * selectImage3;
@property(nonatomic ,strong)UIImage * selectImage4;
@property(nonatomic ,strong)UIImage * selectImage5;
@property(nonatomic ,strong)UIImage * selectImage6;
@property(nonatomic ,strong)UIImage * selectImage7;
@property(nonatomic ,strong)UIImage * selectImage8;

@property(nonatomic,strong)UIButton *getDownButton;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *shareButton;

//保存所有图片按钮下面的线
@property(nonatomic,strong)UIView *getDownBtnView;
@property(nonatomic,strong)UIView *backBtnView;
@property(nonatomic,strong)UIView *shareBtnView;
@end
