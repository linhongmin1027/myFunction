//
//  UIImage+RoundedRectImage.h
//  各种小功能
//
//  Created by iOSDev on 17/3/11.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedRectImage)
+ (UIImage *)createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;
@end
