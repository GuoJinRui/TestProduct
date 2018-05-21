//
//  UIButton+JRButtonCategory.h
//  TestProduct
//
//  Created by homebox on 2018/5/7.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JRImagePositionType)
{
    JRImagePositionTypeLeft,   //图片在左，标题在右，默认风格
    JRImagePositionTypeRight,  //图片在右，标题在左
    JRImagePositionTypeTop,    //图片在上，标题在下
    JRImagePositionTypeBottom  //图片在下，标题在上
};

@interface UIButton (JRButtonCategory)

/**
 *  默认情况下，imageEdgeInsets和titleEdgeInsets都是0。先不考虑height,
 *  if (button.width小于imageView上image的width){图像会被压缩，文字不显示};
 *  if (button.width < imageView.width + label.width){图像正常显示，文字显示不全};
 *  if (button.width >＝ imageView.width + label.width){图像和文字都居中显示，imageView在左，label在右，中间没有空隙};
 */

 /**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现图片和标题的自由排布
 *  该方法需在设置图片和标题之后才调用;
 *  @param type    图片位置类型
 *  @param spacing 图片和标题之间的间隙
 *  设置完成后需要重新设置size确保内部控件不会被压缩。
 */
- (void)setImagePositionWithType:(JRImagePositionType)type spacing:(CGFloat)spacing;

@end
