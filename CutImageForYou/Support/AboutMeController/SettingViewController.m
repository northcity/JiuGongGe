//
//  MEEEEViewController.m
//  leisure
//
//  Created by qianfeng0 on 16/3/3.
//  Copyright © 2016年 陈希. All rights reserved.
//

#import "SettingViewController.h"
//#import "CollectionViewController.h"
//#import "HXViewController.h"
//#import "SDCycleScrollView.h"
//#import "UserFeedBackViewController.h"
#import "MainContentCell.h"
#import <StoreKit/StoreKit.h>
#import <MessageUI/MessageUI.h>
//#import "AboutUSViewController.h"
#import "AboutViewController.h"
const CGFloat kNavigationBarHeight = 44;
const CGFloat kStatusBarHeight = 20;
@interface SettingViewController ()<UITableViewDataSource,SKStoreProductViewControllerDelegate, UITableViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, strong) UIView *headerContentView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat scale;

@property(nonatomic,strong)UIAlertController *alert;


//@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView * backGroundImage;
@property(nonatomic,strong)UIVisualEffectView *effectView;
@property(nonatomic,strong)UIBlurEffect *effect;


@end


@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *pin = [[UIImageView alloc]initWithFrame:CGRectMake(10, 35, 60, 30)];
    pin.image = [UIImage imageNamed:@"pin"];
    
    [self.navigationController.navigationBar addSubview:pin];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    image.image = [UIImage imageNamed:@"titlebar_shadow"];
    
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titlebar_bg1.png"] forBarMetrics:(UIBarMetricsDefault)];
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.title =@"ME";
    
    //信息内容
    
    [self createUI];
    [self.view insertSubview:image aboveSubview:self.tableView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)backAction{
  
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MainContentCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    if (PNCisIPHONEX) {
//        self.tableView.sectionHeaderHeight = 24;
        self.tableView.sectionFooterHeight = 0;
    }
    UIImageView * backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
//    [self.view addSubview:backimage];
    backimage.image = [[UIImage imageNamed:@"QQ20180311-1.jpg"] applyBlurWithRadius:5 tintColor:nil saturationDeltaFactor:1 maskImage:nil];
    backimage.contentMode = UIViewContentModeScaleAspectFill;
    [self.view insertSubview:self.tableView aboveSubview:backimage];
    
    UIButton * backBtn = [Factory createButtonWithTitle:@"" frame:CGRectMake(20, 32, 25, 25) backgroundColor:[UIColor clearColor] backgroundImage:[UIImage imageNamed:@""] target:self action:@selector(backAction)];
    
    [backBtn setImage:[UIImage imageNamed:@"返回 (3).png"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    UILabel * label = [Factory createLabelWithTitle: NSLocalizedString(@"关于", nil)  frame:CGRectMake(60, 25, 100, 40) fontSize:14.f];
    label.font = [UIFont fontWithName:@"Heiti SC" size:16.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    if (PNCisIPAD) {
        self.tableView.cellLayoutMarginsFollowReadableWidth = false;
        //        label.frame = CGRectMake(60, 15, 100, 40);
        //        backBtn.frame = CGRectMake(20, 22, 25, 25);
        //        self.tableView.frame = CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44);
    }
    if (PNCisIPHONEX || PNCisIPAD) {
        backBtn.frame = CGRectMake(20, 48, 25, 25);
        label.frame = CGRectMake(60, 40, 60, 40);
    }
    
    UIView *label111 = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth-80)/2, ScreenHeight-150, 80, 80)];
    label111.backgroundColor = [UIColor whiteColor];
    label111.layer.cornerRadius=12;
    label111.layer.shadowColor=[UIColor grayColor].CGColor;
    label111.layer.shadowOffset=CGSizeMake(0.5, 0.5);
    label111.layer.shadowOpacity=0.8;
    label111.layer.shadowRadius=1.2;
    //    [self.view addSubview:label111];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (PNCisIPHONEX) {
        return 65;

    }
    return 55;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return 180;
    }
    
    if (indexPath.row == 0) {
        NSString *statusString = [[NSUserDefaults standardUserDefaults] objectForKey:@"KaiGuanShiFouDaKai"];
        if ([statusString isEqualToString:@"关"]) {
            return 1;
            
        }else if ([statusString isEqualToString:@"开"]){
            return 62;
        }else{
            return 1;
        }
    }
    
    
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainContentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    if (indexPath.row == 0) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = NSLocalizedString( @"更多独立精品App", nil);
        cell.imageView.image = [UIImage imageNamed:@"沙漏"];
        
        NSString *statusString = [[NSUserDefaults standardUserDefaults] objectForKey:@"KaiGuanShiFouDaKai"];
        if ([statusString isEqualToString:@"开"]) {
            cell.contentView.hidden = NO;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if ([statusString isEqualToString:@"关"]){
            cell.contentView.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.contentView.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else if (indexPath.row == 6){
        cell.textLabel.text = @"我的收藏";
        cell.imageView.image = [UIImage imageNamed:@"星级2"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row == 1){
        cell.textLabel.text = NSLocalizedString(@"意见反馈", nil) ;
        cell.imageView.image = [UIImage imageNamed:@"反馈问题"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row == 7){
        
        cell.textLabel.text = @"清除缓存";
        cell.imageView.image = [UIImage imageNamed:@"new2清除缓存"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
        
    }else if (indexPath.row == 2){
        cell.textLabel.text = NSLocalizedString(@"给个赞", nil) ;
        cell.imageView.image = [UIImage imageNamed:@"星级2"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else if (indexPath.row == 8){
        
        cell.textLabel.text = NSLocalizedString(@"升级信纸", nil) ;
        cell.imageView.image = [UIImage imageNamed:@"增值服务1.png"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *detailLabel = [Factory createLabelWithTitle:  NSLocalizedString(@"¥6 购买", nil) frame:CGRectMake(cell.bounds.size.width - kAUTOWIDTH(180), 5, kAUTOWIDTH(150), 50)];
        [cell.contentView addSubview:detailLabel];
        detailLabel.numberOfLines = 1;
        detailLabel.font = [UIFont fontWithName:@"Heiti SC" size:13.f];
        detailLabel.textAlignment = NSTextAlignmentRight;
    }else if (indexPath.row == 3){
        
        cell.label.frame = CGRectMake(10, 10, ScreenWidth-20, 180);
        if (!_backGroundImage) {
            _backGroundImage = [[UIImageView alloc]initWithFrame:cell.label.bounds];
        }
        [cell.label addSubview:_backGroundImage];
        _backGroundImage.backgroundColor = [UIColor clearColor];
        _backGroundImage.image = [UIImage imageNamed:@"QQ20180311-1.jpg"];
        _backGroundImage.layer.cornerRadius = 6;
        _backGroundImage.layer.masksToBounds = YES;
        _backGroundImage.alpha = 0.6;
        _backGroundImage.contentMode = UIViewContentModeScaleAspectFill;
        
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        
        self.effectView = [[UIVisualEffectView alloc] initWithEffect:self.effect];
        
        self.effectView.frame = cell.label.bounds;
        
        self.effectView.alpha = 1.f;
        self.effectView.userInteractionEnabled = YES;
        [_backGroundImage addSubview:self.effectView];
        
        UILabel * label2 = [Factory createLabelWithTitle:@"* 这就是我心里的一座城池，其他人眼中的一片废墟。" frame:CGRectMake(5,20 ,ScreenWidth-40,55) fontSize:12.f];
        label2.numberOfLines = 0;
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont fontWithName:@"Heiti SC" size:12.f];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [UIColor whiteColor];
//        [cell addSubview:label2];
        
        UILabel * label1 = [Factory createLabelWithTitle:NSLocalizedString(@"春日傍晚\n落日西斜\n远海的岛屿渐渐看不见了\n忽然岛上亮起了一盏盏灯火\n指明了它们的所在\n— 正冈子规", nil) frame:CGRectMake(0,20 ,ScreenWidth-20,170) fontSize:12.f];
        label1.numberOfLines = 0;
        
        label1.font = [UIFont fontWithName:@"Heiti SC" size:13.f];
        label1.textAlignment = NSTextAlignmentCenter;
//        label1.backgroundColor = [UIColor redColor];
        label1.textColor = [UIColor blackColor];
        [cell.contentView addSubview:label1];
        
//        cell.label.backgroundColor = [UIColor blackColor];
        cell.label.alpha = 0.5f;
        
        
        
        cell.label.layer.shadowColor=[UIColor grayColor].CGColor;
        cell.label.layer.shadowOffset=CGSizeMake(0, 4);
        cell.label.layer.shadowOpacity=0.6f;
        cell.label.layer.shadowRadius=12;
//        [self.contentView addSubview:cell.label];
        cell.label.alpha = 0.8;
        
    }
    
    
    
    return cell;
}

- (void)loadAppStoreController{
    // 初始化控制器
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    // 设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    [storeProductViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:@"1383797480"} completionBlock:^(BOOL result, NSError *error){
        if(error){
            NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
        }else{
            // 模态弹出appstore
            [self presentViewController:storeProductViewContorller animated:YES completion:nil];
        }
    }];
 }
//AppStore取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
//        NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1358237203"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

//        [self loadAppStoreController];
        NSString *itunesurl = @"itms-apps://itunes.apple.com/cn/app/id1383797480?mt=8&action=write-review";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
        
    }
    
    
    
    if (indexPath.row == 4) {
        //        NSString * appstoreUrlString = @"https://appsto.re/cn/8phbbb.i";
        //
        //        NSURL * url = [NSURL URLWithString:appstoreUrlString];
        //
        //        if ([[UIApplication sharedApplication] canOpenURL:url])
        //        {
        //            [[UIApplication sharedApplication] openURL:url];
        //        }
        //        else
        //        {
        //            NSLog(@"can not open");
        //        }
        //
        //        //初始化控制器
        //        SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
        //        //设置代理请求为当前控制器本身
        //        storeProductViewContorller.delegate = self;
        //        //加载一个新的视图展示
        //        [storeProductViewContorller loadProductWithParameters:
        //         //appId唯一的
        //         @{SKStoreProductParameterITunesItemIdentifier : @"1150478784"} completionBlock:^(BOOL result, NSError *error) {
        //             //block回调
        //             if(error){
        //                 NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
        //             }else{
        //                 //模态弹出appstore
        //                 [self presentViewController:storeProductViewContorller animated:YES completion:^{
        //
        //                 }
        //                  ];
        //             }
        //         }];
        [self openAppWithIdentifier:@"1353019343"];
        
        
        
    }else if (indexPath.row == 1){
        
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        if (!controller) {
            // 在设备还没有添加邮件账户的时候mailViewController为空，下面的present view controller会导致程序崩溃，这里要作出判断
            NSLog(@"设备还没有添加邮件账户");
        }else{
            controller.mailComposeDelegate = self;
            [controller setSubject:@"九宫格切图(iOS版)反馈"];
            NSString * device = [[UIDevice currentDevice] model];
            NSString * ios = [[UIDevice currentDevice] systemVersion];
            NSString *body = [NSString stringWithFormat:@"请留下您的宝贵建议和意见：\n\n\n以下信息有助于我们确认您的问题，建议保留。\nDevice: %@\nOS Version: %@\n", device, ios];
            [controller setMessageBody:body isHTML:NO];
            NSArray *toRecipients = [NSArray arrayWithObject:@"506343891@qq.com"];
            [controller setToRecipients:toRecipients];
            
            [self presentViewController:controller animated:YES completion:nil];
            
        }
    }
    
    else if (indexPath.row == 0){
        AboutViewController * ab = [[AboutViewController alloc]init];
        [self presentViewController:ab animated:YES completion:nil];
    }else if (indexPath.row == 1){
//        CollectionViewController *cvc = [[CollectionViewController alloc]init];
//        [self.navigationController pushViewController:cvc animated:YES];
    }else if (indexPath.row == 3){

        [self TiShiTongZhi];
        
        
    }else if (indexPath.row == 5){
        
    }
    
}

- (void)TiShiTongZhi{
    
  
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _bgViews = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _bgViews.alpha = 0.6;
//    _bgViews.backgroundColor = [UIColor blackColor];
    [window addSubview:_bgViews];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = _bgViews.frame;
    effectView.alpha = 1.f;
    effectView.userInteractionEnabled = YES;
    [window addSubview:effectView];
    
    _bgView = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth -kAUTOWIDTH(260))/2, ScreenHeight / 2 - kAUTOHEIGHT(100), kAUTOWIDTH(260), kAUTOHEIGHT(180))];
    [window addSubview:_bgView];
    
    
    _bgImageView = [[UIImageView alloc] initWithFrame:_bgView.frame];
    _bgImageView.image = [UIImage imageNamed:@"d.png"];
    [window addSubview: _bgImageView];
    
    _bgImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.5f
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.3
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         _bgImageView.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];
    
    
    
    UIView * bg1 = [[UIView alloc]initWithFrame:CGRectMake(kAUTOWIDTH(260)/2 - 20.f, 19, 35, 35)];
    [_bgImageView addSubview:bg1];
    
    UIImageView * bgImageView1 = [[UIImageView alloc] initWithFrame:bg1.frame];
    bgImageView1.image = [UIImage imageNamed:@"c1.png"];
    //    [bgImageView addSubview:bgImageView1];
    
    UIImageView *bgImageView2 = [[UIImageView alloc] initWithFrame:bg1.frame];
    bgImageView2.image = [UIImage imageNamed:@"增值服务2.png"];
    [_bgImageView addSubview:bgImageView2];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kAUTOWIDTH(20), bgImageView1.frame.origin.y + 40, kAUTOWIDTH(220), kAUTOHEIGHT(91))];
    [label setFont:[UIFont systemFontOfSize:17]];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"Heiti SC" size:14.f];
    
    
    
    label.text = NSLocalizedString(@"您将购买增值服务\n只需要花费¥ 6\n您就可以永久获取不限字数的信纸", nil);
    
    
    
    
    NSString *string = label.text;
    const CGFloat fontSize = 14.0;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    NSUInteger length = [string length];
    //设置字体
    UIFont *baseFont = [UIFont fontWithName:@"Heiti SC" size:12.f];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, length)];//设置所有的字体
    UIFont *boldFont = [UIFont boldSystemFontOfSize:15.f];
    [attrString addAttribute:NSFontAttributeName value:boldFont range:[string rangeOfString:@"20"]];//设置Text这四个字母的字体为粗体
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[string rangeOfString:@"20"]];
    label.attributedText = attrString;
    
    
    
    
    [_bgImageView addSubview:label];
    
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(kAUTOWIDTH(20), CGRectGetMinY(label.frame) + kAUTOHEIGHT(75), kAUTOWIDTH(220), 44)];
    button1.backgroundColor = [UIColor clearColor];
    [_bgImageView addSubview:button1];
    [button1 setTitle:NSLocalizedString(@"立即购买" , nil) forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dismissContactView) forControlEvents:UIControlEventTouchUpInside];
    _bgImageView.userInteractionEnabled = YES;
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [_bgView removeFromSuperview];
    //        [_bgViews removeFromSuperview];
    //        [_bgImageView removeFromSuperview];
    //    });
    
    
}

- (void)openAppWithIdentifier:(NSString *)appId {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (result) {
            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
//- (void)productViewControllerDidFinish:(SKStoreProductViewController *)storeProductVC {
//    [storeProductVC dismissViewControllerAnimated:YES completion:^{
//
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
}

- (void)clearHuancun{
    //第0分区
    NSString *sizeStr = [NSString stringWithFormat:@"%.2fM",[self getCacheSize]];
    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"清除缓存" message:sizeStr preferredStyle:UIAlertControllerStyleActionSheet];
    [actionsheet addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        //删除按钮
        //1.删除sd
//        [[SDImageCache sharedImageCache] clearMemory];//清除内存缓存
//        [[SDImageCache sharedImageCache] clearDisk];//磁盘
        //2.界面下载的缓存
        NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
        //删除
        [[NSFileManager defaultManager] removeItemAtPath:myPath error:nil];
        
    }]];
    [actionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //NSLog(@"取消");
    }]];
    [self presentViewController:actionsheet animated:YES completion:nil];
}
//获取所有缓存大小
- (CGFloat)getCacheSize {
    //缓存 有两类 sdwebimage 还有 每个界面保存的缓存
//    CGFloat sdSize = [[SDImageCache sharedImageCache] getSize];
    NSString *myPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/MyCaches"];
    //获取文件夹中的所有的文件
    NSArray *arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:myPath error:nil];
    unsigned long long size = 0;
    for (NSString *fileName in arr) {
        NSString *filePath = [myPath stringByAppendingPathComponent:fileName];
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += dict.fileSize;
    }
    //1M = 1024 K = 1024*1024字节
    CGFloat totalSize = 1024;
//    (sdSize+size) * 3/1024.0/1024.0;
    return totalSize;
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的反馈发送成功。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}






@end
