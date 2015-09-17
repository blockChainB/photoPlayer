//
//  ViewController.m
//  iosGGitHub
//
//  Created by 李飞翔 on 15/7/31.
//  Copyright (c) 2015年 LFX. All rights reserved.
//

#import "ViewController.h"
#import "LFXPageView.h"
@interface ViewController ()
/** LFXPageView *pageView */
@property (nonatomic,strong) LFXPageView *pageView ;
/** images */
@property (nonatomic,strong) NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LFXPageView *pageView =   [LFXPageView pageView];
    self.pageView = pageView;
    [self.view addSubview:pageView];
    // 设置数据和frame
    pageView.imageNames = self.images;
    
    
    pageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    
}
- (NSArray *)images{
    
    if (_images == nil) {
        
        _images = @[@"1.png",@"2.png",@"3.png"];
    }
    
    return _images;
    
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
