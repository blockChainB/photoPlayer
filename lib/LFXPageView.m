//
//  LFXPageView.m
//  06-UIScrollView的分页
//
//  Created by apple on 15/6/24.
//  Copyright (c) 2015年 LFXPageView. All rights reserved.
//

#import "LFXPageView.h"

@interface LFXPageView() <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
/** 定时器 */
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation LFXPageView

+ (instancetype)pageView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

/**
 *  初始化
 */
- (void)awakeFromNib
{
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    
    // 单页时自动隐藏pageControl
    self.pageControl.hidesForSinglePage = YES;
    // 设置页码图片
    [self.pageControl setValue:[UIImage imageNamed:@"current"] forKeyPath:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"other"] forKeyPath:@"_pageImage"];
    
    // 开启定时器
    [self startTimer];
}

/**
 *  根据图片名数据做一些操作
 */
- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    // 先移除所有的imageView
    // 让self.scrollView.subviews数组中的所有对象都执行removeFromSuperview方法
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 根据图片名数据创建对应的imageView
    CGFloat w = self.scrollView.frame.size.width;
    CGFloat h = self.scrollView.frame.size.height;
    for (int i = 0; i<imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.image = [UIImage imageNamed:imageNames[i]];
        imageView.frame = CGRectMake(i * w, 0, w, h);
        [self.scrollView addSubview:imageView];
    }
    
    // 设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(imageNames.count * w, 0);
    
    // 设置总页数
    self.pageControl.numberOfPages = imageNames.count;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.scrollView.frame.size.width;
    for (int i = 0; i<self.imageNames.count; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGRect frame = imageView.frame;
        frame.origin.x = i * w;
        imageView.frame = frame;
    }
}

#pragma mark - 定时器相关
- (void)startTimer
{
    // 返回一个自动开始执行任务的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage:) userInfo:@"123" repeats:YES];
    
    // 修改NSTimer在NSRunLoop中的模式：NSRunLoopCommonModes
    // 主线程不管在处理什么操作，都会抽时间处理NSTimer
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [self.timer invalidate];
}

// 程序一启动就会创建一条主线程

/**
 *  显示下一页
 */
- (void)nextPage:(NSTimer *)timer
{
    // 计算出下一页
    NSInteger page = self.pageControl.currentPage + 1;
    
    // 如果超过了最后一页
    if (page == self.imageNames.count) {
        page = 0;
    }
    
    // 让scrollView滚动到下一页
    CGPoint offset = CGPointMake(page * self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    self.pageControl.currentPage = page;
}

/**
 *  当用户即将开始拖拽scrollView时，停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

/**
 *  当用户已经结束拖拽scrollView时，开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

@end
