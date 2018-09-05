//
//  AppDelegate.m
//  TestProduct
//
//  Created by homebox on 2018/4/25.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationViewController.h"
#import "BaseTabBarViewController.h"
#import "JRLeftViewController.h"
#import "JRRightViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// 这个方法是你在启动时的第一次机会来执行代码
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 设置抽屉
    JRLeftViewController * leftVC = [JRLeftViewController new];
    BaseTabBarViewController * centerVC = [BaseTabBarViewController new];
    JRRightViewController * rightVC = [JRRightViewController new];
    BaseNavigationViewController * leftNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:leftVC];
    BaseNavigationViewController * rightNavVC = [[BaseNavigationViewController alloc] initWithRootViewController:rightVC];
    MMDrawerController * drawerVC = [[MMDrawerController alloc] initWithCenterViewController:centerVC leftDrawerViewController:leftNavVC rightDrawerViewController:rightNavVC];
    drawerVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;//打开手势
    drawerVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;// 关闭手势
    drawerVC.maximumLeftDrawerWidth = 200;
    drawerVC.maximumRightDrawerWidth = 200;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:drawerVC];
    // 提交设置并显示窗口
    [self.window makeKeyAndVisible];
    NSLog(@"%s", __func__);
    return YES;
}
// 应用程序启动，并进行初始化时候调用该方法,这个方法允许你在显示app给用户之前执行最后的初始化操作
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    NSLog(@"%s", __func__);
    return YES;
}

// 从活动状态转入不活跃状态时调用
- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSLog(@"%s", __func__);
}

// 已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //使用此方法释放共享资源，保存用户数据，使计时器无效并存储足够的应用程序状态信息，以便将应用程序还原到其当前状态，以防稍后终止。
    //如果您的应用程序支持后台执行，当用户退出时,则调用此方法applicationWillTerminate：。
    NSLog(@"%s", __func__);
}

// 将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 称为从后台到活动状态的过渡的一部分，在这里可以撤消进入后台时所做的许多更改。
    NSLog(@"%s", __func__);
}

// 已经进入活跃状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 在应用程序处于非活动状态时，重新启动已暂停（或尚未启动）的任何任务。 如果应用程序以前位于后台，则可以选择刷新用户界面。
    NSLog(@"%s", __func__);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // 当应用程序即将终止时调用，适用保存数据.
    NSLog(@"%s", __func__);
}

//// 点在接收器的坐标系中时，递归调用-pointInside：withEvent :
//- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//    
//}
//
//// 判断点是否在视图的范围内，若在返回YES
//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//
//}

//- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view;
//- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view;
//- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;
//- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;


@end
