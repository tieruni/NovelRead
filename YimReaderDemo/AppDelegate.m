//
//  AppDelegate.m
//  YimReaderDemo
//
//  Created by Yimmm on 2019/8/17.
//  Copyright © 2019 Yimmm. All rights reserved.
//

#import "AppDelegate.h"

#import "klotFeedVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    klotFeedVC * LoginVC = [[klotFeedVC alloc]init];
    
    
//    //1.创建Tab所属的ViewController
//    // 看书首页
//    ReaderHomeViewController *homeVC = [[ReaderHomeViewController alloc] init];
//    UITabBarItem* homeTabItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
//    homeTabItem.title = @"看书";
//    homeVC.tabBarItem = homeTabItem;
////    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
////    homeNav.navigationBar.translucent = NO;
//
//
////    //工作
//    PersonalCenterPageViewController * PersonalCenterPageVC = [[PersonalCenterPageViewController alloc]init];
////    UINavigationController *PersonalCenterPageVCNav = [[UINavigationController alloc] initWithRootViewController:PersonalCenterPageVC];
////    PersonalCenterPageVCNav.navigationBar.translucent = NO;
////    UITabBarItem * PerSonCenItem = [[UITabBarItem alloc]initWithTitle:@"个人中心" image:[UIImage imageNamed:@"PersonalCenterPageVC.jpg"] tag:1];
//    UITabBarItem * PerSonCenItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
//    PerSonCenItem.title = @"个人中心";
//    PersonalCenterPageVC.tabBarItem = PerSonCenItem;
//
//
//    //2、创建一个数组，放置多有控制器
//    NSArray *vcArray = [NSArray arrayWithObjects:homeVC,PersonalCenterPageVC, nil];
//
//    //3、创建UITabBarController，将控制器数组设置给UITabBarController
//    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
//    //设置多个Tab的ViewController到TabBarViewController
//    tabBarVC.viewControllers = vcArray;
//    //4、将UITabBarController设置为Window的RootViewController
//    self.window.rootViewController = tabBarVC;
    self.window.rootViewController = LoginVC;
    //显示Window
    [self.window makeKeyAndVisible];
    


    
    
    return YES;
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
