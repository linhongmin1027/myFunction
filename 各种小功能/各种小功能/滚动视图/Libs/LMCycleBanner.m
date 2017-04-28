//
//  LMCycleBanner.m
//  各种小功能
//
//  Created by iOSDev on 17/4/28.
//  Copyright © 2017年 iOSDev. All rights reserved.
//

#import "LMCycleBanner.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface LMCycleBannerCollectionViewCell : UICollectionViewCell
@property(nonatomic ,strong) id model;
@end
@interface LMCycleBannerCollectionViewCell ()
@property(nonatomic,weak)UIImageView *imageView;

/** 占位图片 **/
@property(nonatomic ,strong) UIImage *placeholderImage;
@end
@implementation LMCycleBannerCollectionViewCell
-(UIImage *)placeholderImage{
    if (!_placeholderImage) {
        CGFloat width=kScreenWidth;
        CGFloat height=120;
        UIImage *placeholder=[UIImage imageNamed:@"default_img"];
        _placeholderImage=placeholder;
    }
    return _placeholderImage;

}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;


}
-(void)setup{
    self.backgroundColor=[UIColor whiteColor];
    UIImageView *imageView=[[UIImageView alloc]init];
    _imageView=imageView;
    [self.contentView addSubview:imageView];

}
-(void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame=self.contentView.bounds;
}
-(void)setModel:(id)model{
    _model=model;
    NSString *imageUrl=[model valueForKey:@"imageUrl"];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:self.placeholderImage];
    


}
@end

/** 组数 */
#define kItemGroupCount 4
/** 轮播图将要开始拖动发出通知 **/
NSString *const kCycleBannerWillBeginDraggingNotification =
@"kCycleBannerWillBeginDraggingNotification";
NSString *const kCycleBannerDidEndDeceleratingNotification =
@"kCycleBannerDidEndDeceleratingNotification";

/** 轮播图结束滑动发出通知 **/
/** cellID **/
NSString * const LMCycleBannerConllectionViewCellResumeIdentifer =
@"LMCycleBannerConllectionViewCellResumeIdentifer";

@interface LMCycleBanner ()<UICollectionViewDelegate ,UICollectionViewDataSource>
/** 轮播图View **/
@property(nonatomic ,weak)UICollectionView *mainView;
/** 轮播图布局 **/
@property(nonatomic,weak) UICollectionViewFlowLayout *flowLayout;

/**总item的数量**/
@property(nonatomic ,assign)NSUInteger totalItemsCount;

/** 轮播定时器 **/
@property(nonatomic ,weak) NSTimer *timer;

/** 页码控件 **/
@property(nonatomic,weak)UIPageControl *mainPageControl;

/** block **/
@property(nonatomic ,copy)LMCycleBannerBlock block;

/** 占位图片 **/
@property(nonatomic ,weak)UIImage *placeholderImage;

@end

@implementation LMCycleBanner
{
    // item索引
    NSInteger _itemIndex;


}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (!self) return nil;
    [self initialization];
    [self setupUI];
    return self;



}
-(void)setupUI{
    self.backgroundColor=[UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    _flowLayout=flowLayout;
    flowLayout.minimumLineSpacing=0;
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    UICollectionView *mainView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _mainView=mainView;
    [self addSubview:mainView];
    mainView.backgroundColor=[UIColor whiteColor];
    mainView.pagingEnabled=YES;
    mainView.showsVerticalScrollIndicator=NO;
    mainView.showsHorizontalScrollIndicator=NO;
    mainView.scrollsToTop=NO;
    mainView.delegate=self;
    mainView.dataSource=self;
    [mainView registerClass:[LMCycleBannerCollectionViewCell class] forCellWithReuseIdentifier:LMCycleBannerConllectionViewCellResumeIdentifer];
    //pageContoll
    UIPageControl *mainPageControl =[[UIPageControl alloc]init];
    _mainPageControl =mainPageControl;
    [self addSubview:mainPageControl];
    //单页隐藏
    mainPageControl.hidesForSinglePage =YES;
    mainPageControl.currentPageIndicatorTintColor=[UIColor greenColor];
    mainPageControl.pageIndicatorTintColor=[UIColor whiteColor];
    mainPageControl.userInteractionEnabled=NO;
    [mainPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainPageControl.superview.mas_right).with.offset(8);
        make.bottom.equalTo(mainPageControl.superview.mas_bottom).with.offset(8);
        
    }];
    


}
#pragma mark --Setter
-(void)setImageArray:(NSArray *)imageArray{
    _imageArray=imageArray;
    //停止计时器
    [self invalidateTimer];
    
    //重新计算数据源
    _totalItemsCount=imageArray.count*kItemGroupCount;
    _mainPageControl.numberOfPages=imageArray.count;


}
-(void)initialization{
    _autoScrollTimeInterval =5.f ;


}
+(instancetype)bannerViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage block:(LMCycleBannerBlock)block{
    LMCycleBanner *bannerView=[[self alloc]initWithFrame:frame];
    bannerView.block =block;
    bannerView.placeholderImage=placeholderImage;
    return bannerView;
    return nil;
}
#pragma mark --UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalItemsCount;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LMCycleBannerCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:LMCycleBannerConllectionViewCellResumeIdentifer forIndexPath:indexPath];
    NSUInteger itemIndex =indexPath.item %_imageArray.count;
    cell.model=_imageArray[itemIndex];
    return cell;


}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_block) {
        _block(indexPath.item %_imageArray.count);
    }



}
#pragma mark -- UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCycleBannerWillBeginDraggingNotification object:nil];
   //取消定时器

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _itemIndex=[self currentIndex];
    _mainPageControl.currentPage=[self currentIndex] %_imageArray.count;


}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger halfTotalItemsCount =_totalItemsCount *0.5;
    NSUInteger padding =_itemIndex % (_totalItemsCount/kItemGroupCount);
    CGFloat leftInset =(halfTotalItemsCount +padding -1) *kScreenWidth;
    CGFloat rightInset =(halfTotalItemsCount +padding -1) *kScreenWidth -(padding *2+1)*kScreenWidth;
    
    //根据当前索引变换contentInset
    _mainView.contentInset=UIEdgeInsetsMake(0, -leftInset, 0, -rightInset);
    //结束滑动应该 默认滚动到中间位置
    NSUInteger targetIndex =_totalItemsCount * 0.5;
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    [_mainView setContentOffset:CGPointMake(_mainView.contentOffset.x-kScreenWidth, 0)];
    
    //发送结束滚动的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCycleBannerDidEndDeceleratingNotification object:nil];
    
    //设置定时器
    [self setupTimerWithTimeInterval:_autoScrollTimeInterval];





}
-(void)setupTimerWithTimeInterval:(NSTimeInterval)timeInterval{
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer=timer;
    /**
     *  NSDefaultRunLoopMode  滚动视图的模式无效
     *
     *  UITrackingRunLoopMode 滚动视图的模式才有效
     *
     *  NSRunLoopCommonModes  两者兼容
     */
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];




}
#pragma mark 销毁定时器
-(void)invalidateTimer{
    [_timer invalidate];
    _timer=nil;

}
#pragma mark --自动滚动
-(void)automaticScroll{
    if (_totalItemsCount ==0) return;
    _mainView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    NSUInteger currentIndex =[self currentIndex];
    NSUInteger targetIndex =currentIndex +1;
    if (targetIndex >=_totalItemsCount) {
        targetIndex =_totalItemsCount *0.5;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        //立即调用定时器
        [_timer fire];
        return;
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];

}
-(NSUInteger)currentIndex{
    if (_mainView.mas_width ==0 || _mainView.mas_height ==0) {
        return 0;
    }
    NSInteger index =0;
    index=(_mainView.contentOffset.x +_flowLayout.itemSize.width*0.5)/_flowLayout.itemSize.width;
    return MAX(0, index);

}
@end


















