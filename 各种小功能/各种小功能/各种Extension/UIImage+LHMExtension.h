//
//  UIImage+LHMExtension.h
//  各种小功能
//
//  Created by iOSDev on 17/3/18.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LHMExtension)
/**
 *  获取圆角图片
 *
 *  @param image       <#image description#>
 *  @param borderWidth <#borderWidth description#>
 *  @param color       <#color description#>
 *
 *  @return <#return value description#>
 */

+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

/**
 *  指定区域图片的截图
 *
 *  @param sourceImage 原始图片
 *  @param clipRect    截取范围
 *
 *  @return 截图图片
 */
+ (UIImage *)imageWithSourceImage:(UIImage *)sourceImage
                         clipRect:(CGRect)clipRect;

/**
 *  截取指定位置的图片
 *
 *  @param bounds <#bounds description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)croppedImage:(CGRect)bounds;
@end
