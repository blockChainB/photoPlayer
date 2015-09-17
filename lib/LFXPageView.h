//
//  LFXPageView.h
//  06-UIScrollView的分页
//
//  Created by apple on 15/6/24.
//  Copyright (c) 2015年 LFXPageView. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFXPageView : UIView
+ (instancetype)pageView;

/** 所有的图片名数据 */
@property (nonatomic, strong) NSArray *imageNames;
@end
