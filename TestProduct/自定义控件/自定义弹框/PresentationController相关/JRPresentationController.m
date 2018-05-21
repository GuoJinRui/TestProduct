//
//  JRPresentationController.m
//  TestProduct
//
//  Created by homebox on 2018/4/28.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRPresentationController.h"

@interface JRPresentationController()

@property(nonatomic, strong)UIVisualEffectView * effectView;

@end

@implementation JRPresentationController

//调整presented的圆角效果
- (UIView *)presentedView{
    UIView *pretedView = self.presentedViewController.view;
    pretedView.layer.cornerRadius = 15.0f;
    return pretedView;
}

// 返回容器视图内具体视图的边界
- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect oldBounds = self.containerView.bounds;
    return CGRectInset(oldBounds, 50, 100);//通过第二个参数 dx 和第三个参数 dy 重置第一个参数 rect 作为结果返回。重置的方式为，首先将 rect 的坐标（origin）按照(dx,dy) 进行平移，然后将 rect 的大小（size） 宽度缩小2倍的 dx，高度缩小2倍的 dy。CGRectOffset(CGRect rect, CGFloat dx, CGFloat dy)：则是rect按照（dx,dy）进行平移。
}

// 呈现过渡即将开始
- (void)presentationTransitionWillBegin
{
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _effectView.frame = self.containerView.frame;
    _effectView.alpha = 0.0;
    [self.containerView addSubview:_effectView];
    [self.containerView addSubview:self.presentedView];
    
    id transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _effectView.alpha = 0.4;
        self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, 0.92, 0.92);

    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

// 在呈现过渡已经结束,该方法提供一个布尔变量来判断过渡效果是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed) {
        [_effectView removeFromSuperview];
    }
}

// 消失过渡将要开始
- (void)dismissalTransitionWillBegin
{
    id transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _effectView.alpha = 0.0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];}

// 消失过渡已经结束
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (!completed) {
        //一旦要自定义动画，必须自己手动移除控制器
        [self.presentedView removeFromSuperview];
        [_effectView removeFromSuperview];
    }
    [[[UIApplication sharedApplication]keyWindow]addSubview:self.presentingViewController.view];
}


@end
