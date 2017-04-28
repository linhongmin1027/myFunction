//
//  LMCycleBanner.h
//  各种小功能
//
//  Created by iOSDev on 17/4/28.
//  Copyright © 2017年 iOSDev. All rights reserved.
//轮播图的封装

#import <UIKit/UIKit.h>
typedef void(^LMCycleBannerBlock) (NSUInteger didSelectIndex);
@interface LMCycleBanner : UIView
/** 图片url数组**/
@property(nonatomic , copy) NSArray *imageArray;
/** 自动滚动时间间隔 默认5s **/
@property(nonatomic ,assign) NSTimeInterval autoScrollTimeInterval;


@end
