//
//  AppDelegate.m
//  CutImageForYou
//
//  Created by chenxi on 2018/5/11.
//  Copyright © 2018年 chenxi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LaunchViewController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate
#pragma mark —页面跳转
- (void)jumpViewController:(NSDictionary*)tfdic{
    
    if (@available(iOS 9.0, *)) {
        UIApplicationShortcutItem *cameraItem = [tfdic objectForKey:UIApplicationLaunchOptionsShortcutItemKey];
        if ([cameraItem.type isEqualToString:@"typeOne"]){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ViewController *rootVC = (ViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
                [rootVC selectedXiangCeImage];
            });
        }
    } else {
        // Fallback on earlier versions
    }
}
- (void)setup3DTouch:(UIApplication *)application{
    /**
     type 该item 唯一标识符
     localizedTitle ：标题
     localizedSubtitle：副标题
     icon：icon图标 可以使用系统类型 也可以使用自定义的图片
     userInfo：用户信息字典 自定义参数，完成具体功能需求
     */
    
    if (@available(iOS 9.0, *)) {
        if (@available(iOS 9.1, *)) {
            UIApplicationShortcutIcon *cameraIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCapturePhoto];
            UIApplicationShortcutItem *cameraItem = [[UIApplicationShortcutItem alloc] initWithType:@"typeOne" localizedTitle:@"九宫格切图" localizedSubtitle:@"" icon:cameraIcon userInfo:nil];
            application.shortcutItems = @[cameraItem];
        } else {
            // Fallback on earlier versions
        }
    } else {
        // Fallback on earlier versions
    }
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setup3DTouch:application];
    [self jumpViewController:launchOptions];
    [self chuShiHuaBomb];
    return YES;
}

- (void)chuShiHuaBomb{
    [Bmob registerWithAppKey:@"075c9e426a01a48a81aa12305924e532"];
    NSString *nowStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"KaiGuanShiFouDaKai"];
    
    if (![nowStatus isEqualToString:@"开"]) {
        //查找GameScore表
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"appKaiGuan"];
        //查找GameScore表里面id为0c6db13c的数据
        [bquery getObjectInBackgroundWithId:@"e337a46d78" block:^(BmobObject *object,NSError *error){
            if (error){
                //进行错误处理
            }else{
                //表里有id为0c6db13c的数据
                if (object) {
                    //得到playerName和cheatMode
                    NSString *KaiGuanStatus = [object objectForKey:@"JiuGongGeDuLiApp"];
                    NSLog(@"%@=========",KaiGuanStatus);
                    [[NSUserDefaults standardUserDefaults] setObject:KaiGuanStatus forKey:@"KaiGuanShiFouDaKai"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
