//
//  UIImage+JRImageCategory.h
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JRImageCategory)

// 生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)imageWithColor:(UIColor *)color;

@end
