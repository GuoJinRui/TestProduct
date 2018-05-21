//
//  JRDefineTabBar.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRDefineTabBar.h"

@interface JRDefineTabBar()

@property (nonatomic, strong) UIButton * bigBtn ;

@end

@implementation JRDefineTabBar

- (instancetype)init
{
    if (self = [super init]) {
        self.bigBtn = [[UIButton alloc] init];
        [self.bigBtn setImage:[UIImage imageNamed:@"taBar_center"] forState:UIControlStateNormal];
        [self.bigBtn setTitle:@"发布" forState:UIControlStateNormal];
        // 自定义item的title要与其他item的title的font保持一致
        self.bigBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.bigBtn addTarget:self action:@selector(didClickPublishBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.bigBtn.adjustsImageWhenHighlighted = NO;
        [self.bigBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.bigBtn];
        [self.bigBtn setImagePositionWithType:JRImagePositionTypeTop spacing:5];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.mj_w/3;
    // 设置其他位置按钮
    NSUInteger count = self.subviews.count;
    for (NSUInteger i = 0 , j = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:class]) {
            view.mj_w = self.mj_w / 3;
            view.mj_x = self.mj_w * j / 3;
            j++;
            if (j == 3/2) {
                // 设置中间按钮位置
                CGSize bigSize = self.bigBtn.size;
                self.bigBtn.frame = CGRectMake(0, -(bigSize.height - view.frame.size.height), width, bigSize.height);
                self.bigBtn.centerX = self.mj_w / 2;
                // 这里因为设置了自定义按钮，相当于将原来的按钮空出来所以还需要在执行一次++操作
                j++;
            }
        }
    }
}

// 点击事件
- (void) didClickPublishBtn:(UIButton*)sender {
    if (self.clickPublishBut) {
        self.clickPublishBut();
    }
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.bigBtn];
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.bigBtn pointInside:newP withEvent:event]) {
            return self.bigBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
    return [super hitTest:point withEvent:event];

}

@end
