//
//  WXFarmDetailViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXFarmDetailViewController.h"
#import "WXTopView.h"
#import "WXBigPic.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface WXFarmDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIButton *productButton;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UIView *bgView;

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

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)addTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth - 50) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //隐藏UITableViewCell的分隔线
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview: self.tableView];
}

#pragma mark - 添加tableviewHeader（商品图片）
-(void)addproductPic
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth/2)];
    self.scrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.tableHeaderView = self.scrollView;
    self.scrollView.delegate = self;
    
//    self.productButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.productButton.frame = CGRectMake(0, 0, screenWidth, screenHeigth);
//    [self.scrollView addSubview:self.productButton];
    
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
        self.imageView = [[UIImageView alloc] init];
        
        // 设置UIImageView中的图片
        NSString *imgName = [NSString stringWithFormat:@"%d.jpg", i + 1];
        self.imageView.image = [UIImage imageNamed:imgName];
        
        // 计算每个UIImageView在UIScrollView中的x坐标值
        CGFloat imgX = i * imgW;
        // 设置imgView的frame
        self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
        self.imageView.tag = i+1;
        // 把imgView添加到UIScrollView中
        [self.scrollView addSubview:self.imageView];
        
       

    }
    //为需要放大的图片添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(magnifyImage)];
    
    [self.imageView addGestureRecognizer:tap];
    
//    [self.productButton addTarget:self action:@selector(ClickProductPic:) forControlEvents:UIControlEventTouchUpInside];
    
    
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

-(void)magnifyImage{
    NSLog(@"局部放大");
    
    [WXBigPic showImage:self.imageView];//调用方法
}

//-(void)ClickProductPic:(UIButton *)sender{
//    
//    WXproductpicView *productPic = [[WXproductpicView alloc]init];
//    [self presentViewController:productPic animated:YES completion:nil];
//}

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
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if (indexPath.row == 0) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
        bgView.backgroundColor = [UIColor whiteColor];
        [cell addSubview:bgView];
        self.bgView = bgView;
        
        [self firstCellContent];
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
    }else if (indexPath.row == 1){
        UILabel *size = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth /2, 44)];
        size.text = @"产品参数";
        size.textAlignment = NSTextAlignmentLeft;
        size.font = [UIFont systemFontOfSize:14];
        size.textColor = [UIColor blackColor];
        [cell addSubview:size];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        //单元格右侧图标
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }else if (indexPath.row == 2){
        UILabel *size = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth /2, 44)];
        size.text = @"产品尺码／类型";
        size.textAlignment = NSTextAlignmentLeft;
        size.font = [UIFont systemFontOfSize:14];
        size.textColor = [UIColor blackColor];
        [cell addSubview:size];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        //单元格右侧图标
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        //隐藏UITableViewCell的分隔线
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        
    }
    
    return cell;
}



#pragma mark -delegate方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 130;
    }else{
        return 40;
    }
//    return 140;
}

/**
 * 显示完全分割线
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - cell添加内容

/**
 * 添加第一行商品信息内容
 */
-(void)firstCellContent
{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth*0.8, 50)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"春装新品拉升空间地方卡拉斯京的法律框架阿斯利康地方";
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 2;
    [self.bgView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(screenWidth *0.85, 5, 1, 45)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.bgView addSubview:lineView];
    
    //分享
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(screenWidth * 0.9, 2, screenWidth * 0.1, 30);
    [shareButton setImage:[UIImage imageNamed:@"share_it"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(ClickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:shareButton];
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth * 0.9, 35, screenWidth *0.1, 20)];
    shareLabel.text = @"分享";
    shareLabel.font = [UIFont systemFontOfSize:11];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.textColor = [UIColor blackColor];
    [self.bgView addSubview:shareLabel];
    
    //价格
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.frame.size.height, screenWidth * 0.2, 20)];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = @"$20";
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:16];
    [self.bgView addSubview:priceLabel];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.frame.size.height+priceLabel.frame.size.height, screenWidth * 0.2, 20)];
    price.textColor = [UIColor grayColor];
    price.text = @"价格:100";
    price.textAlignment = NSTextAlignmentLeft;
    price.font = [UIFont systemFontOfSize:10];
    [self.bgView addSubview:price];
    
    //快递费，销量，卖家地址
    UILabel *postageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.bgView.frame.size.height - 20, 30, 20)];
    postageLabel.textColor = [UIColor grayColor];
    postageLabel.text = @"快递：";
    postageLabel.textAlignment = NSTextAlignmentLeft;
    postageLabel.font = [UIFont systemFontOfSize:10];
    [self.bgView addSubview:postageLabel];
    
    UILabel *postage = [[UILabel alloc]initWithFrame:CGRectMake(40, self.bgView.frame.size.height - 20, screenWidth/3-60, 20)];
    postage.textColor = [UIColor grayColor];
    postage.text = @"免费";
    postage.textAlignment = NSTextAlignmentLeft;
    postage.font = [UIFont systemFontOfSize:10];
    [self.bgView addSubview:postage];
    
    UILabel *saleNum = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /3, self.bgView.frame.size.height - 20, screenWidth/3, 20)];
    saleNum.textColor = [UIColor grayColor];
    saleNum.text = @"月销23423笔";
    saleNum.textAlignment = NSTextAlignmentCenter;
    saleNum.font = [UIFont systemFontOfSize:10];
    [self.bgView addSubview:saleNum];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /3 *2, self.bgView.frame.size.height - 20, screenWidth /3-10, 20)];
    address.textColor = [UIColor grayColor];
    address.text = @"浙江";
    address.textAlignment = NSTextAlignmentRight;
    address.font = [UIFont systemFontOfSize:10];
    [self.bgView addSubview:address];
    
}

-(void)ClickShareButton:(UIButton *)sender
{
    NSArray *imageArray = @[[UIImage imageNamed:@"my-xiaoxiang"]];
    
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容" images:imageArray url:[NSURL URLWithString:@"http://mob.com"] title:@"分享标题" type:SSDKContentTypeAuto];
        
        
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state,SSDKPlatformType platformType,NSDictionary *userData,SSDKContentEntity *contentEntity,NSError *error,BOOL end){
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
        }];
    }

}

/**
 * 添加第二行产品参数等内容
 */
-(void)productSize
{
   
    
}
@end
