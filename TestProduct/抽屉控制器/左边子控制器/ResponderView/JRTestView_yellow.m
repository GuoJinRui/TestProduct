//
//  JRTestView_yellow.m
//  TestProduct
//
//  Created by homebox on 2018/5/10.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRTestView_yellow.h"

@implementation JRTestView_yellow

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"yellow:%s", __func__);
}


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"yellow:%s\n", __func__);
    NSLog(@"yellow:%@\n", [super hitTest:point withEvent:event]);

//    for (UIView * view in self.subviews) {
//        if ([view pointInside:point withEvent:event]) {
//
//        }
//    }
    return [super hitTest:point withEvent:event];
}

@end
