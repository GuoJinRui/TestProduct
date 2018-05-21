//
//  JRTestView_red.m
//  TestProduct
//
//  Created by homebox on 2018/5/10.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRTestView_red.h"

@implementation JRTestView_red

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"red:%s", __func__);
//}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"yellow:%s", __func__);
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"red:%s\n", __func__);
    NSLog(@"red:%@\n", [super hitTest:point withEvent:event]);
    return [super hitTest:point withEvent:event];
}

@end
