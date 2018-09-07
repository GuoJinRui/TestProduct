//
//  BaseViewController.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

// 判断当前页面是不是根视图，如果是就禁止掉右划手势，如果不是就打开
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 第一层视图关闭系统的pop左滑手势，开启抽屉效果
    if (self.navigationController.viewControllers.firstObject == self) {
        self.navigationController.interactivePopGestureRecognizer.enabled = false;
        
        /**
         * 原来抽屉效果的打开与关闭是放到了自定义NavigationController中去判断的但是这样在开启系统左滑返回手势后，会发生有时返回时会打开抽屉界面，尽管我们的判断中已经将抽屉的打开手势全部关闭，经打印也确实已经关闭，但是因为在VC的基类中我们将interactivePopGestureRecognizer开启，可能在后来又导致打开了边缘滑动打开抽屉的效果，所以发生手势冲突。
         * 所以将抽屉控制的开关放到了基类viewDidAppearf方法中，开启、关闭交互式手势的后面,这样会反复确认关闭或开启抽屉效果达到有效控制的目的
         */

        // 打开抽屉效果
        MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = true;
        // 关闭抽屉效果
        MMDrawerController * drawerController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
