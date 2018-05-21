//
//  JRVCAnimatedTransitioning.m
//  TestProduct
//
//  Created by homebox on 2018/5/2.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRVCAnimatedTransitioning.h"

@implementation JRVCAnimatedTransitioning

/**
 * UIViewControllerAnimatedTransitioning
 * 该协议中的方法允许定义一个动画制作器对象，该对象创建用于在固定时间内在屏幕上或屏幕外转换视图控制器的动画。
 * 使用此协议创建的动画不得为交互式！！！要创建交互式转场，必须将动画制作器对象与控制动画时间的另一个对象---实现UIPercentDrivenInteractiveTransition协议或者UIViewControllerInteractiveTransitioning协议的对象结合使用。
 */

#pragma --------------------------常用代理方法
 /**
  * 系统给出一个切换上下文，我们根据上下文环境返回这个切换所需要的花费时间
  * 一般就返回动画的时间就好了，SDK会用这个时间来在百分比驱动的切换中进行帧的计算
  */
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.8;
}

/**
 * This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
 * 如果转换是交互式的而不是百分比交互式转换，则此方法只能是nop。”NOP"指令即空指令，运行该指令时单片机什么都不做，但是会占用一个指令的时间。
 * 当指令间需要有延时（给外部设备足够的响应时间；或是软件的延时等），可以插入“NOP”指令
 *
 * 有关过渡中涉及的对象的信息以上下文对象的形式传递,使用该对象提供的信息在指定的持续时间内将目标视图控制器的视图打开或关闭
 */
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.presented) {// present动画
        // 1、获取目标视图控制器
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        // 2、设置目标控制器视图的初始化数据
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        // 3、得到转场结束时某个VC应在位置的frame。以此处为例：VC的frameOfPresentedViewInContainerView方法中设置CGRectInset(oldBounds, 50, 100)后 则finalFrame的起点应该是（50,100）
        CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
        NSLog(@"finalFrame == %@", NSStringFromCGRect(finalFrame));
//        toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
        toVC.view.frame = CGRectMake(screenBounds.size.width/2, finalFrame.origin.y, 0, finalFrame.size.height);
        //也可以直接通过UITransitionContextToViewKey、UITransitionContextFromViewKey获取到控制器视图，但是
//        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        // 4、 将目标控制器的视图添加到容器视图中，与之对应的是- (UIView *)containerView，即VC切换所发生的view容器，开发者应该将切出的view移除，将切入的view加入到该view容器中
        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toVC.view];
        // 5、动画效果
        [UIView animateWithDuration:0.8 animations:^{
            toVC.view.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];
    }else{ // dismiss动画
        
    }
}

/**
 * 过渡动画已完成
 */
- (void)animationEnded:(BOOL) transitionCompleted
{
    
}

@end
