//
//  UIImage+JRImageCategory.m
//  TestProduct
//
//  Created by homebox on 2018/5/3.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "UIImage+JRImageCategory.h"

@implementation UIImage (JRImageCategory)

+ (UIImage *)imageWithColor:(UIColor *)color {

    return [[[self alloc] init] creatNewImageWithColor:color];
}

- (UIImage *)imageWithColor:(UIColor *)color{

    return [self creatNewImageWithColor:color];
}

- (UIImage *)creatNewImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    return image;
}

@end
