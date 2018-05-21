//
//  UIButton+JRButtonCategory.m
//  TestProduct
//
//  Created by homebox on 2018/5/7.
//  Copyright © 2018年 homebox. All rights reserved.
//

#import "UIButton+JRButtonCategory.h"

@implementation UIButton (JRButtonCategory)

- (void)setImagePositionWithType:(JRImagePositionType)type spacing:(CGFloat)spacing
{
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    NSString * title = [self titleForState:UIControlStateNormal];
    CGSize titleSize = (title.length > 0 ? [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}] : CGSizeZero);
    switch (type) {
        case JRImagePositionTypeLeft: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
            break;
        }
        case JRImagePositionTypeRight: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, 0, imageSize.width + spacing);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing, 0, - titleSize.width);
            break;
        }
        case JRImagePositionTypeTop: {
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (imageSize.height + spacing), 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing), 0, 0, - titleSize.width);
            // 重新设置高度确保button内控件的的高度不会被压缩
            CGFloat width = self.size.width;
            [self setValue:[NSValue valueWithCGSize:CGSizeMake(width, imageSize.height + spacing + titleSize.height)] forKey:@"size"];
            break;
        }
        case JRImagePositionTypeBottom: {
            self.titleEdgeInsets = UIEdgeInsetsMake(- (imageSize.height + spacing), - imageSize.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, - (titleSize.height + spacing), - titleSize.width);
            // 重新设置高度确保button内控件的的高度不会被压缩
            CGFloat width = self.size.width;
            [self setValue:[NSValue valueWithCGSize:CGSizeMake(width, imageSize.height + spacing + titleSize.height)] forKey:@"size"];
            break;
        }
    }
}
@end
