//
//  AppDelegate.m
//  TEST
//
//  Created by Jack on 24/2/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "AppDelegate.h"
#import "SQNotice.h"
#import "NoticeViewController.h"
#import "ProcessViewController.h"
#import "Macro.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.updater = [[Updater alloc] init];
    [self.updater checkUpdate];
    
// Override point for customization after application launch.
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    UINavigationController *navigationController_process = [tabBarController viewControllers][1];
//    ProcessViewController *processViewController = [navigationController_process viewControllers][0];
//    [processViewController init];
//    UINavigationController *navigationController_notice = [tabBarController viewControllers][2];
//    NoticeViewController *noticeViewController = [navigationController_notice viewControllers][0];
    
//    noticeViewController.notices = _notices;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        [[UITabBar appearance] setTintColor:TINTBLUE];
        [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    }
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
 
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
