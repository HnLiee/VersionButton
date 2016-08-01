//
//  AppDelegate.m
//  VersionButton
//
//  Created by HnLiee on 16/8/1.
//  Copyright © 2016年 HnLiee. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate () <UIAlertViewDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 应用版本更新
    [self VersionButton];
    
    return YES;
}

// 应用版本更新
- (void)VersionButton
{
    // 获取发布版本的Version
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=1130233257"] encoding:NSUTF8StringEncoding error:nil];
    if (string != nil && [string length] > 0 && [string rangeOfString:@"version"].length == 7) {
        [self checkAppUpdate:string];
    }
}

#pragma mark - 当前版本与新上线版本做比较
- (void)checkAppUpdate:(NSString *)appInfo
{
    // 获取当前版本
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *newAppVersion = [appInfo substringFromIndex:[appInfo rangeOfString:@"\"version\":"].location+10];
    newAppVersion = [[newAppVersion substringToIndex:[newAppVersion rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    /**
     * 判断，如果当前版本与发布的版本不同，则进入更新。如果相等，那么当前就是最高版本
     */
    if (![newAppVersion isEqualToString:version]) {
//        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"有新版本啦,请尽快更新哦!"] preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"暂不更新" style:UIAlertActionStyleCancel handler:nil];
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:nil];
//        [alertView addAction:cancelAction];
//        [alertView addAction:okAction];
//        [[self presentViewController:alertView animated:YES completion:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"有新版本啦,请尽快更新哦!"] delegate:self.class cancelButtonTitle:@"知道了" otherButtonTitles:@"前往更新",nil];
        alert.delegate = self;
        [alert show];
    }
}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
//        NSString *string = @"http://itunes.apple.com/cn/app/y-y-助-手/id1130233257?mt=8";
        NSString *string = @"http://baidu.com";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
