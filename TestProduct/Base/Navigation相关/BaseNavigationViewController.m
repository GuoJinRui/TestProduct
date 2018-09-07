//
//  BaseNavigationViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "BaseNavigationViewController.h"

@interface BaseNavigationViewController ()

@end

@implementation BaseNavigationViewController

+ (void)initialize
{
    // 统一设置导航栏背景，颜色
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    // 如果设置了背景图片则背景颜色将不起作用，一般用图片，因为这样可以自定义navigationBar透明渐变效果
    [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRGB:0xDC143C]] forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setBarTintColor:[UIColor redColor]];//colorWithRGB:0xDC143C
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]};
    // 去掉底部黑边
    [navigationBar setShadowImage:[[UIImage alloc] init]];
}

// 重写push方法修改返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //全部修改返回按钮,但是会失去右滑返回的手势
    if (self.viewControllers.count >= 1) { //此时的viewController是将要被push出来的viewController
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
//        MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popSelfAction
{
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.viewControllers.count == 2) { // 此时第二层控制器尚未出栈所以要判断count是否为2
//        // 打开抽屉效果
//        MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    }
    return [super popViewControllerAnimated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //重写了leftbarItem之后,需要添加如下方法才能重新启用右滑返回
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        // 直接这样设置会导致iOS视图push的时候偶尔卡住,push不过去问题，导航栏的标题是下个页面的，view还是当前的
        self.interactivePopGestureRecognizer.delegate =(id)self;
        // 原因是手势pop的问题. 当处在navigation的根控制器时候, 做一个侧滑pop的操作, 看起来没任何变化, 但是再次push其它控制器时候就会出现上述问题了。so 还需要补救措施！！！，具体查看BaseViewController
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
