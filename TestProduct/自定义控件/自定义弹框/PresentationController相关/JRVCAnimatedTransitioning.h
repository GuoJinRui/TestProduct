//
//  JRVCAnimatedTransitioning.h
//  TestProduct
//
//  Created by homebox on 2018/5/2.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRVCAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
/**
 * 用于记录控制器是创建还是销毁
 * YES是处于创建新控制器状态，NO是处于销毁状态
 * 另外一种方式是分成两个类分开创建控制器的创建动画效果和销毁效果！！！
 */
@property (nonatomic, assign) BOOL presented;

@end
