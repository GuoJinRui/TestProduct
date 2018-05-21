//
//  JRTransitionDelegate.m
//  TestProduct
//
//  Created by homebox on 2018/5/7.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRTransitionDelegate.h"
#import "JRPresentationController.h"
#import "JRVCAnimatedTransitioning.h"

@implementation JRTransitionDelegate

/**
 * UIViewControllerTransitioningDelegate这个接口的作用比较简单单一，在需要VC切换的时候系统会像实现了这个接口的对象询问是否需要使用自定义的切换效果
 * 视图控制器从转换委托中检索动画器对象，并使用它来执行动画。
 
 * 从一个符合UIViewControllerTransitioningDelegate协议的转换委托对象创建动画器对象。在呈现视图控制器时，将控制器modalPresentationStyles属性设置为UIModalPresentationCustom，并将转换委托分配给视图控制器的transitioningDelegate属性。视图控制器从转换委托中检索动画器对象，并使用它来执行动画。可以提供单独的动画器对象来呈现和解除视图控制器；
 */

ShareSingleM(Transition)

// UIViewControllerTransitioningDelegate
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    return [[JRPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //创建实现UIViewControllerAnimatedTransitioning协议的类
    JRVCAnimatedTransitioning * animTrans = [[JRVCAnimatedTransitioning alloc] init];
    //将其状态改为出现
    animTrans.presented = YES;
    return animTrans;
}

//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//
//}
//
//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
//{
//
//}

@end
