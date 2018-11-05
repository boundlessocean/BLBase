//
//  MyAppDelegate.m
//  BLBase
//
//  Created by fuhaiyang on 10/29/2018.
//  Copyright (c) 2018 fuhaiyang. All rights reserved.
//

#import "MyAppDelegate.h"
@import BLBase.BLTabBarController;
@import BLBase.BLNavigationController;
#import "MyViewController.h"
@implementation MyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.rootViewController = [self initianizeTabBar];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    return YES;
}

- (BLTabBarController *)initianizeTabBar{
    BLTabBarController *tabbar = BLTabBarController.new;
    tabbar.selectColor = [UIColor redColor];
    tabbar.defaultColor = [UIColor greenColor];
    [tabbar initializeNav:[self initianizeNav] VC:MyViewController.new title:@"a" image:[UIImage imageNamed:@"返回"] selectedImage:[UIImage imageNamed:@"返回"]];
    [tabbar initializeNav:[self initianizeNav] VC:MyViewController.new title:@"b" image:[UIImage imageNamed:@"返回"] selectedImage:[UIImage imageNamed:@"返回"]];
    return tabbar;
}


- (BLNavigationController *)initianizeNav{
    BLNavigationController *nav = [BLNavigationController new];
    nav.backImage = [UIImage imageNamed:@"返回"];
    nav.bgColor = [UIColor redColor];
    nav.titleColor = [UIColor whiteColor];
    nav.titleFont = [UIFont systemFontOfSize:12];
    return nav;
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
