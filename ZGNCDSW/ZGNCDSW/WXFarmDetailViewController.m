//
//  WXFarmDetailViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXFarmDetailViewController.h"
#import "WXTopView.h"
#import "WXproductpicView.h"
@interface WXFarmDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIButton *productButton;

@end

@implementation WXFarmDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"商品详情"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    [self addTableView];
    [self addproductPic];
}

-(void)addTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth - 50) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview: self.tableView];
}

#pragma mark - 添加tableviewHeader（商品图片）
-(void)addproductPic
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth/2)];
    self.scrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.tableHeaderView = self.scrollView;
    self.scrollView.delegate = self;
    
    self.productButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.productButton.frame = CGRectMake(0, 0, screenWidth, screenHeigth);
    [self.scrollView addSubview:self.productButton];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(screenWidth *0.3, screenHeigth /2-30, screenWidth * 0.4, 20)];
    //    pageControl.backgroundColor = [UIColor redColor];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1]];
    [self.tableView addSubview:self.pageControl];
    
    CGFloat imgW = screenWidth;
    CGFloat imgH = screenHeigth /2;
    ;
    CGFloat imgY = 0;
    
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
        
        imgView.tag = i+1;
        // 把imgView添加到UIScrollView中
//        [self.scrollView addSubview:imgView];
        [self.productButton addSubview:imgView];

    }
    
    [self.productButton addTarget:self action:@selector(ClickProductPic:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 设置UIScrollView的contentSize(内容的实际大小)`
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

-(void)ClickProductPic:(UIButton *)sender{
    
    WXproductpicView *productPic = [[WXproductpicView alloc]init];
    [self presentViewController:productPic animated:YES completion:nil];
}

-(void)backButton:(id)sender{
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

#pragma mark -UITableViewDataSource数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    return cell;
}

#pragma mark -delegate方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
