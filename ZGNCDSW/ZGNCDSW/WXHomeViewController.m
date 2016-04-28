//
//  WXHomeViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXHomeViewController.h"
#import "WXSearchBar.h"
#import "UIView+Extension.h"
#import "PrefixHeader.pch"
#import "WXCategoryTableViewCell.h"
//#import "WXNewsTableCell.m"
#import "WXRecommendTableViewCell.h"

@interface WXHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)UITableView *rootTableView;
// 创建一个用来引用计时器对象的属性
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,strong)NSMutableArray *newsListArray;

@end

@implementation WXHomeViewController



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

// 实现即将开始拖拽的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止计时器
    // 调用invalidate一旦停止计时器, 那么这个计时器就不可再重用了。下次必须重新创建一个新的计时器对象。
    [self.timer invalidate];
    
    // 因为当调用完毕invalidate方法以后, 这个计时器对象就已经废了，无法重用了。所以可以直接将self.timer设置为nil
    self.timer = nil;
}

// 实现拖拽完毕的方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    // 重新启动一个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 再次修改一下新创建的timer的优先级
    // 修改self.timer的优先级与控件一样
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXSearchBar *searchBar = [WXSearchBar searchBar];
    searchBar.width = self.view.frame.size.width * 0.8;
    searchBar.height = 30;
    
    
    self.navigationItem.titleView = searchBar;
    
    self.newsListArray = [NSMutableArray array];
    
    
    [self addScrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.rootTableView reloadData];
}


#pragma mark -设置轮播图片
-(void)addScrollView{
    
    self.rootTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth) style:UITableViewStylePlain];
    self.rootTableView.delegate = self;
    self.rootTableView.dataSource = self;
    self.rootTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.rootTableView.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:self.rootTableView];
    
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = CGRectMake(0, 0, screenWidth, screenHeigth *0.3);
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.rootTableView.tableHeaderView = self.scrollView;
    self.scrollView.delegate = self;
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(screenWidth *0.3, screenHeigth *0.25, screenWidth * 0.4, 40)];
    //    pageControl.backgroundColor = [UIColor redColor];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1]];
    [self.rootTableView addSubview:self.pageControl];
    
    CGFloat imgW = screenWidth;
    CGFloat imgH = screenHeigth * 0.3
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
    
    
    // 创建一个"计时器"控件NSTimer控件
    // 通过scheduledTimerWithInterval这个方法创建的计时器控件, 创建好以后自动启动
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    
    // 修改self.timer的优先级与控件一样
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 改变self.timer对象的优先级
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    //    [self.scrollView bringSubviewToFront:self.pageControl];
    
    
    
    
}

// 自动滚动图片的方法
// 因为在创建计时器的时候, 指定了时间间隔是1.0秒,所以下面这个方法每隔一秒钟执行一次
- (void)scrollImage
{
    // 每次执行这个方法的时候, 都要让图片滚动到下一页
    // 如何让UIScrollView滚动到下一页?
    // 1. 获取当前的UIPageControl的页码
    NSInteger page = self.pageControl.currentPage;
    
    // 2. 判断页码是否到了最后一页, 如果到了最后一页, 那么设置页码为0（回到第一页）。如果没有到达最后一页, 则让页码+1
    if (page == self.pageControl.numberOfPages - 1) {
        // 表示已经到达最后一页了
        page = 0; // 回到第一页
    } else {
        page++;
    }
    // 3. 用每页的宽度 * (页码 + 1) == 计算除了下一页的contentOffset.x
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    
    // 4. 设置UIScrollView的contentOffset等于新的偏移的值
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
    // 如果图片现在已经滚动到最后一页了, 那么就滚动到第一页
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else{
//        return _newsListArray.count;
        return 10;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellStr = @"cell1";
            WXCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell == nil) {
                cell = [[WXCategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            
            [cell.categoryButton addTarget:self action:@selector(ClickCategoryButton:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
            
        }else{
            static NSString *cellStr = @"cell";
            WXRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell == nil) {
                cell = [[WXRecommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            
            return cell;
        }
    }else{
        
        if (indexPath.row == 0) {
            static NSString *cellStr = @"cell2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            cell.textLabel.text = @"行业资讯";
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            return cell;
        }else{
            
            static NSString *cellStr = @"cell3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
            }
            
            UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, screenWidth - 20, 100)];
            newView.backgroundColor = [UIColor whiteColor];
            [cell addSubview:newView];
            
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];

            
            UIImageView *newImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 90, 90)];
            [newImage setImage:[UIImage imageNamed:@"news_list1"]];
            [newView addSubview:newImage];
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth * 0.25, 0, screenWidth * 0.6, 25)];
            titleLabel.text = @"asdfasdfasdfasdgasdga";
            titleLabel.textColor = [UIColor grayColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:14];
            [newView addSubview:titleLabel];
            
            UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth * 0.25, 25, screenWidth * 0.6, 50)];
            detailLabel.text = @"asdfasdfasdfasdgaadgfasdfasdfkjl;askdjf;lasdjfsdga";
            detailLabel.textColor = [UIColor grayColor];
            detailLabel.textAlignment = NSTextAlignmentCenter;
            detailLabel.font = [UIFont systemFontOfSize:14];
            detailLabel.numberOfLines = 2;
            [newView addSubview:detailLabel];
            
            
            
            return cell;
        }
        
    }
    
       
}


-(void)ClickCategoryButton:(UIButton *)sender{
    if (sender.tag == 0) {
        
    }
}

#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 180;
        
    }else{
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 120;
        }
    }
    
}


@end
