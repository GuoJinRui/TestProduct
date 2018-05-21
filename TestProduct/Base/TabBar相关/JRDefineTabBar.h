//
//  JRDefineTabBar.h
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^didClickPublishBtn)(void);

@interface JRDefineTabBar : UITabBar

@property(assign,nonatomic) int itemCount;

@property (nonatomic,copy) didClickPublishBtn clickPublishBut;

@end
