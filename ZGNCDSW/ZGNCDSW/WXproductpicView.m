//
//  WXproductpicView.m
//  ZGNCDSW
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXproductpicView.h"

@interface WXproductpicView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIButton *bgButton;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation WXproductpicView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addImageView];
    
}

-(void)addImageView
{
    CGFloat imgW = screenWidth;
    CGFloat imgH = screenHeigth / 2;
    CGFloat imgY = screenHeigth /4;
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = CGRectMake(0, 0, screenWidth, screenHeigth);
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgButton addTarget:self action:@selector(ClickBgButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bgButton];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(screenWidth *0.3, screenHeigth -20, screenWidth * 0.4, 20)];
    //    pageControl.backgroundColor = [UIColor redColor];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1]];
    [self.view addSubview:self.pageControl];

 
    // 1. 循环创建5个UIImageView添加到ScrollView中
    for (int i = 0; i < 4; i++) {
        // 创建一个UIImageView
        UIImageView *imgView = [[UIImageView alloc] init];
        
        // 设置UIImageView中的图片
        NSString *imgName = [NSString stringWithFormat:@"%d.jpg", i + 1];
        imgView.image = [UIImage imageNamed:imgName];
        
        // 计算每个UIImageView在UIScrollView中的x坐标值
        CGFloat imgX = i * imgW;
        // 设置imgView的frame
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        // 把imgView添加到UIScrollView中
        [self.scrollView addSubview:imgView];
    }
    
    // 设置UIScrollView的contentSize(内容的实际大小)
    CGFloat maxW = self.scrollView.frame.size.width * 4;
    self.scrollView.contentSize = CGSizeMake(maxW, 0);
    
    
    // 实现UIScrollView的分页效果
    // 当设置允许分页以后, UIScrollView会按照自身的宽度作为一页来进行分页。
    self.scrollView.pagingEnabled = YES;
    
    // 隐藏水平滚动指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 指定UIPageControl的总页数
    self.pageControl.numberOfPages = 4;
    
    // 指定默认是第0页
    self.pageControl.currentPage = 0;


}

// 实现UIScrollView的滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    // 如何计算当前滚动到了第几页？
    // 1. 获取滚动的x方向的偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    // 用已经偏移了得值, 加上半页的宽度
    offsetX = offsetX + (scrollView.frame.size.width * 0.5);
    
    // 2. 用x方向的偏移的值除以一张图片的宽度(每一页的宽度)，取商就是当前滚动到了第几页（索引）
    int page = offsetX / scrollView.frame.size.width;
    
    // 3. 将页码设置给UIPageControl
    self.pageControl.currentPage = page;
    
    //NSLog(@"滚了，要在这里根据当前的滚动来计算当前是第几页。");
}


-(void)ClickBgButton:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
