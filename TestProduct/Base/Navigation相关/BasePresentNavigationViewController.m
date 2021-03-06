//
//  BasePresentNavigationViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/14.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "BasePresentNavigationViewController.h"

@interface BasePresentNavigationViewController ()

@end

@implementation BasePresentNavigationViewController

+ (void)initialize
{
    // 统一设置导航栏背景，颜色
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    // 如果设置了背景图片则背景颜色将不起作用
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@"apple"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBarTintColor:[UIColor redColor]];//colorWithRGB:0xDC143C
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]};
    // 去掉底部黑边
    //    [navigationBar setShadowImage:[[UIImage alloc] init]];
}

// 重写push方法修改返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //全部修改返回按钮,但是会失去右滑返回的手势
    if (self.viewControllers.count == 1) {
        // 关于hidesBottomBarWhenPushed的用法存在很多误区，
        /**
         * 场景：视图控制器A -> push -> 视图控制器B，A显示TabBar，B隐藏
         * 误区1、在跳转时直接设置A的hidesBottomBarWhenPushed属性为YES。这样设置会使A push B没有问题但是B pop A时TabBar不显示。
         * 误区2、直接在A的viewWillAppear中设置hidesBottomBarWhenPushed为NO及A.tabBarController.tabBar.hidden = NO，试图解决上面的问题，然并卵·····
         
         * 官方关于hidesBottomBarWhenPushed属性的解释：大意如下：
         * “已经添加”到“导航控制器”的“子控制器”，可选择性的展示屏幕底部的toolbar。 “最顶部”的子控制器的属性值（hidesBottomBarWhenPushed）决定toolbar是否可见，如果属性值为YES，toolbar隐藏，为NO，则可见。
         * 注意双引号引住的关键词，系统在push B的时候，B控制器其实已经加入到导航控制器的子控制器中了，此时，B才是最顶部的控制器，so B的hidesBottomBarWhenPushed属性才是正确控制tabbar隐藏的关键，而不是A的。
         
         * 正确的使用方式：
         */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 修改左边item
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navigationBar_leftItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(popSelfAction)];
    // 关闭抽屉效果
    MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    
    [super pushViewController:viewController animated:animated];
}

- (void)popSelfAction
{
    if (self.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:^{
            // 打开抽屉效果
            MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        }];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //重写了leftbarItem之后,需要添加如下方法才能重新启用右滑返回
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
