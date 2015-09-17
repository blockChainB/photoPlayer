# photoPlayer
图片轮播器
#拖入文件
#导入头文件

import "LFXPageView.h"

#初始化
  /** images */
@property (nonatomic,strong) NSArray *images;

    LFXPageView *pageView =   [LFXPageView pageView];
    self.pageView = pageView;
    [self.view addSubview:pageView];
    
#设置数据和frame
    pageView.imageNames = self.images;
    pageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    
    
    - (NSArray *)images{
    
    if (_images == nil) {
        
        _images = @[@"1.png",@"2.png",@"3.png"];
    }
    
    return _images;
    

#效果
![](3.png)
![](2.png)