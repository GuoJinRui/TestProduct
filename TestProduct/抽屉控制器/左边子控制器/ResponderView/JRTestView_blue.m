//
//  JRTestView_blue.m
//  TestProduct
//
//  Created by homebox on 2018/5/10.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "JRTestView_blue.h"

@implementation JRTestView_blue

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"blue:%s", __func__);
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"blue:%s\n", __func__);
    NSLog(@"blue:%@\n", [super hitTest:point withEvent:event]);
    return [super hitTest:point withEvent:event];
}

@end
