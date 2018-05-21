//
//  BaseTabBarViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "BasePresentNavigationViewController.h"
#import "JRDefineTabBar.h"
#import "JRFirstViewController.h"
#import "JRSecondViewController.h"
#import "JRThirdViewController.h"

@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self addChildViewControllers];
    [self setupTabBar];
}

- (void)setupTabBar
{
    // 自定义tabBar ,用KVC 替换系统的tabbar
    JRDefineTabBar * tabBar = [[JRDefineTabBar alloc]init];
    // 利用KVC 修改系统的tabbar
    [self setValue: tabBar forKeyPath:@"tabBar"];
    __weak typeof(self) weakSelf = self;
    [tabBar setClickPublishBut:^{
        JRSecondViewController * secondVC = [JRSecondViewController new];
        BasePresentNavigationViewController * baseNavVC = [[BasePresentNavigationViewController alloc] initWithRootViewController:secondVC];
        [weakSelf presentViewController:baseNavVC animated:YES completion:^{
            baseNavVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"navigationBar_leftItem"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(popSelfAction)];
        }];
    }];
}
- (void)popSelfAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)addChildViewControllers
{
    // 初始化时这里有两种效果，1、只初始化两边的控制器，将中间控制器空出来，点击中间按钮弹出下一级的控制器（即自定义按钮点击事件）；2、中间视图控制器与两边视图控制器处于同一级别，仅仅是做了一个放大按钮效果
    [self addChildrenViewController:[JRFirstViewController new] withTitle:@"First" withNomalImageName:@"tabBar_home_nomal" andSelectImageName:@"tabBar_home_selected"];
    [self addChildrenViewController:[JRThirdViewController new] withTitle:@"Third" withNomalImageName:@"tabBar_direction_nomal" andSelectImageName:@"tabBar_direction_selected"];
    // 效果2的实现方式；
//    [self addChildrenViewController:[JRSecondViewController new] withTitle:@"Second" withNomalImageName:@"taBar_center" andSelectImageName:@"taBar_center"];

}

- (void)addChildrenViewController:(UIViewController *)childVC withTitle:(NSString *)title withNomalImageName:(NSString *)nomalImageName andSelectImageName:(NSString *)selectedImageName{
    //第一种解决方法:因为系统默认是将我们选中的图片渲染为蓝色的,所以在这里我们可以将选中的图片设置为初始值,使其不被渲染就可以;这种方法需要我们设置每一个tabBarItem的selectedImage属性,比较繁琐;
    childVC.tabBarItem.image = [[UIImage imageNamed:nomalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 另外一种方式就是直接使用Assets.xcasset中打开右侧工具栏在选中对应图片的Image set --> Render As 中选择Original Image即可
    // 改变tabBarItem字体的颜色
    [childVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:14.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:14.0], NSFontAttributeName, nil] forState:UIControlStateSelected];
    childVC.tabBarItem.title = title;
    // 直接在TabBarController中设置子控制器的title会使navigation的title和tabBarItem.title的行为发生改变。
    // 同样直接在root视图控制器中使用self.title也会会同时改变 navigationController的title 和 tabBarItem的title,而且tabBarButton的对象也发生了改变。但是如果你通过self.title设置的title和tabBarItem初始化时的title一致的话，tabBarButton却不会发生改变。用self.navigationController.title = @"XXXX"; 或 self.navigationItem.title = @"XXXX";来设置导航的title也不会影响。
    // 这需要特别主意！！！！
    //    childVC.title = @"XXXX";
    BaseNavigationViewController * baseNav = [[BaseNavigationViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:baseNav];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
@end
