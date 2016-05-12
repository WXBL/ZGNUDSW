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
#import "WXCommentController.h"
#import "MBProgressHUD.h"
#import "WXBuyCartController.h"
@interface WXFarmDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)UIButton *productButton;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UIView *cellBgView;

@property (nonatomic,strong)UIView *sizeBgView;//参数
@property (nonatomic,strong)UIView *sizeView;
@property (nonatomic,strong)UITableView *sizeTableView;
@property (nonatomic,strong)UIView *buyCartView;
//参数数组
@property (nonatomic,strong)NSMutableArray *sizeArray;

@property (nonatomic,strong)UIView *commentView;//评论
@end

@implementation WXFarmDetailViewController

-(NSMutableArray *)sizeArray{
    if (!_sizeArray) {
        self.sizeArray=[NSMutableArray array];
    }
    return _sizeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self setNavBar];
    
    [self addTableView];
    [self addproductPic];
    [self addbuyCart];
    
}
//设置导航
-(void)setNavBar
{
    
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"商品详情"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    UIButton *buyCart = [UIButton buttonWithType:UIButtonTypeCustom];
    buyCart.frame = CGRectMake(screenWidth -50, 10, 50, 40);
    [buyCart setImage:[UIImage imageNamed:@"detailBar_cart_press"] forState:UIControlStateNormal];
    [buyCart addTarget:self action:@selector(ClickBuyCartButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:buyCart];

}

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([self.sizeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.sizeTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.sizeTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.sizeTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 * 添加tableview到view上
 */
-(void)addTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth - 90) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    //隐藏UITableViewCell的分隔线
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
    [self.view addSubview: self.tableView];
}

/**
 * 添加购物车，结算view
 */
-(void)addbuyCart
{
    self.buyCartView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth - 40, screenWidth, 40)];
    self.buyCartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.buyCartView];
    
    UIButton *customService = [UIButton buttonWithType:UIButtonTypeCustom];
    customService.frame = CGRectMake(0, 0, screenWidth *0.4/3, 40);
    //    [keep setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [customService setTitle:@"客服" forState:UIControlStateNormal];
    [customService setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [customService setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    customService.titleLabel.font = [UIFont systemFontOfSize:12];
    [customService.layer setBorderColor:[UIColor colorWithWhite:0.9 alpha:1].CGColor];
    [customService.layer setBorderWidth:0.5];
    [customService.layer setMasksToBounds:YES];
    [customService addTarget:self action:@selector(ClickServiceButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:customService];
    
    UIButton *store = [UIButton buttonWithType:UIButtonTypeCustom];
    store.frame = CGRectMake(screenWidth *0.4/3, 0, screenWidth *0.4/3, 40);
    //    [keep setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [store setTitle:@"商家" forState:UIControlStateNormal];
    [store setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [store setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    store.titleLabel.font = [UIFont systemFontOfSize:12];
    [store.layer setBorderColor:[UIColor colorWithWhite:0.9 alpha:1].CGColor];
    [store.layer setBorderWidth:0.5];
    [store.layer setMasksToBounds:YES];
    [store addTarget:self action:@selector(ClickStoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:store];
    
    UIButton *keep = [UIButton buttonWithType:UIButtonTypeCustom];
    keep.frame = CGRectMake(screenWidth *0.4/3*2, 0, screenWidth *0.4/3, 40);
//    [keep setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [keep setTitle:@"收藏" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    keep.titleLabel.font = [UIFont systemFontOfSize:12];
    [keep.layer setBorderColor:[UIColor colorWithWhite:0.9 alpha:1].CGColor];
    [keep.layer setBorderWidth:0.5];
    [keep.layer setMasksToBounds:YES];
    [keep addTarget:self action:@selector(ClickKeepButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:keep];
    
    UIButton *addbuyCart = [UIButton buttonWithType:UIButtonTypeCustom];
    addbuyCart.frame = CGRectMake(screenWidth * 0.4, 0, screenWidth*0.3, 40);
    addbuyCart.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    [addbuyCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addbuyCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addbuyCart.titleLabel.font = [UIFont systemFontOfSize:13];
    [addbuyCart addTarget:self action:@selector(addBuyCartButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:addbuyCart];
    
    UIButton *buyLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    buyLabel.frame = CGRectMake(screenWidth * 0.7, 0, screenWidth*0.3, 40);
    buyLabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1];
    [buyLabel setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyLabel.titleLabel.font = [UIFont systemFontOfSize:13];
    [buyLabel addTarget:self action:@selector(ClickBuyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:buyLabel];
}

-(void)ClickServiceButton:(UIButton *)sender{
    
}

-(void)ClickStoreButton:(UIButton *)sender{
    
}
-(void)ClickKeepButton:(UIButton *)sender{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"收藏成功！";
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];

}

//点击加入购物车按钮触发事件
-(void)addBuyCartButton:(UIButton *)sender{
    
}

//点击立即购买按钮触发事件
-(void)ClickBuyButton:(UIButton *)sender{
    
}

//点击购物车触发事件
-(void)ClickBuyCartButton:(id)sender
{
    WXBuyCartController *buyCartViewController = [[WXBuyCartController alloc]init];
    [self presentViewController:buyCartViewController animated:YES completion:nil];
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
    
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return 4;
    }else{
//        return self.sizeArray.count;
        return 10;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        static NSString *cellStr = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        
        
        
        if (indexPath.row == 0) {
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
            bgView.backgroundColor = [UIColor whiteColor];
            [cell addSubview:bgView];
            self.cellBgView = bgView;
            
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
            size.text = @"选择颜色，尺码";
            size.textAlignment = NSTextAlignmentLeft;
            size.font = [UIFont systemFontOfSize:14];
            size.textColor = [UIColor blackColor];
            [cell addSubview:size];
            
            cell.backgroundColor = [UIColor whiteColor];
            
            //单元格右侧图标
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if(indexPath.row == 3){
            
            self.commentView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, screenWidth, 170)];
            self.commentView.backgroundColor = [UIColor whiteColor];
            
            [cell addSubview:self.commentView];
            
            [self commentContent];
            
            cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            //隐藏UITableViewCell的分隔线
            [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            
            
        }
        
        //点击cell时不变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        static NSString *cellStr = @"sizecell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.textLabel.text = @"sdf";
        return cell;
    }
   
}



#pragma mark -delegate方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (indexPath.row == 1) {
            [self showProductSize];
        }
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (indexPath.row == 0) {
            return 130;
        }else if(indexPath.row == 3){
            return 180;
        }else{
            return 40;
        }
    }else{
        return 40;
    }

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

/**
 * 显示产品的参数
 */
-(void)showProductSize
{
    self.sizeBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth)];
    self.sizeBgView.backgroundColor = [UIColor blackColor];
    self.sizeBgView.alpha = 0.3;
    [self.view addSubview:self.sizeBgView];
    
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = CGRectMake(0, 0, screenWidth, screenHeigth);
    bgButton.backgroundColor = [UIColor clearColor];
    [bgButton addTarget:self action:@selector(ClickBgButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sizeBgView addSubview:bgButton];
    
    UIView *sizeView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth/2, screenWidth, screenHeigth/2)];
    sizeView.backgroundColor = [UIColor whiteColor];
    sizeView.alpha = 1;
    [self.view addSubview:sizeView];
    self.sizeView = sizeView;
    
    UILabel *productSize = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth, sizeView.frame.size.height *0.1)];
    productSize.text = @"产品参数";
    productSize.textColor = [UIColor blackColor];
    productSize.font = [UIFont systemFontOfSize:18];
    productSize.textAlignment = NSTextAlignmentCenter;
    [self.sizeView addSubview:productSize];
    
    self.sizeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, productSize.frame.size.height, screenWidth, sizeView.frame.size.height * 0.8) style:UITableViewStylePlain];
    self.sizeTableView.delegate = self;
    self.sizeTableView.dataSource = self;
    self.sizeTableView.backgroundColor = [UIColor whiteColor];
    self.sizeTableView.tableFooterView = [[UIView alloc]init];
    [self.sizeView addSubview:self.sizeTableView];
    
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(0, sizeView.frame.size.height-sizeView.frame.size.height*0.1, screenWidth, sizeView.frame.size.height*0.1);
    [finishButton setBackgroundColor: [UIColor colorWithRed:0.4 green:0.7 blue:0.3 alpha:1]];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(ClickFinishButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sizeView addSubview:finishButton];

    
}
-(void)ClickBgButton:(id)sender{
    self.sizeBgView.hidden = YES;
    self.sizeView.hidden = YES;
}

-(void)ClickFinishButton:(id)sender{
    self.sizeBgView.hidden = YES;
    self.sizeView.hidden = YES;
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
    [self.cellBgView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(screenWidth *0.85, 5, 1, 45)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.cellBgView addSubview:lineView];
    
    //分享
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(screenWidth * 0.9, 2, screenWidth * 0.1, 30);
    [shareButton setImage:[UIImage imageNamed:@"share_it"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(ClickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.cellBgView addSubview:shareButton];
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth * 0.9, 35, screenWidth *0.1, 20)];
    shareLabel.text = @"分享";
    shareLabel.font = [UIFont systemFontOfSize:11];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.textColor = [UIColor blackColor];
    [self.cellBgView addSubview:shareLabel];
    
    //价格
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.frame.size.height, screenWidth * 0.2, 20)];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = @"$20";
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:16];
    [self.cellBgView addSubview:priceLabel];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(10, titleLabel.frame.size.height+priceLabel.frame.size.height, screenWidth * 0.2, 20)];
    price.textColor = [UIColor grayColor];
    price.text = @"价格:100";
    price.textAlignment = NSTextAlignmentLeft;
    price.font = [UIFont systemFontOfSize:10];
    [self.cellBgView addSubview:price];
    
    //快递费，销量，卖家地址
    UILabel *postageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.cellBgView.frame.size.height - 20, 30, 20)];
    postageLabel.textColor = [UIColor grayColor];
    postageLabel.text = @"快递：";
    postageLabel.textAlignment = NSTextAlignmentLeft;
    postageLabel.font = [UIFont systemFontOfSize:10];
    [self.cellBgView addSubview:postageLabel];
    
    UILabel *postage = [[UILabel alloc]initWithFrame:CGRectMake(40, self.cellBgView.frame.size.height - 20, screenWidth/3-60, 20)];
    postage.textColor = [UIColor grayColor];
    postage.text = @"免费";
    postage.textAlignment = NSTextAlignmentLeft;
    postage.font = [UIFont systemFontOfSize:10];
    [self.cellBgView addSubview:postage];
    
    UILabel *saleNum = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /3, self.cellBgView.frame.size.height - 20, screenWidth/3, 20)];
    saleNum.textColor = [UIColor grayColor];
    saleNum.text = @"月销23423笔";
    saleNum.textAlignment = NSTextAlignmentCenter;
    saleNum.font = [UIFont systemFontOfSize:10];
    [self.cellBgView addSubview:saleNum];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /3 *2, self.cellBgView.frame.size.height - 20, screenWidth /3-10, 20)];
    address.textColor = [UIColor grayColor];
    address.text = @"浙江";
    address.textAlignment = NSTextAlignmentRight;
    address.font = [UIFont systemFontOfSize:10];
    [self.cellBgView addSubview:address];
    
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
 * 添加第三行用户评论
 */
-(void)commentContent
{
    
    UILabel *userComment = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth*0.2, 40)];
    userComment.text = @"用户评价";
    userComment.textColor = [UIColor grayColor];
    userComment.textAlignment = NSTextAlignmentLeft;
    userComment.font = [UIFont systemFontOfSize:16];
    [self.commentView addSubview:userComment];
    
    
    UILabel *user = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, screenWidth*0.3, 30)];
    user.text = @"jwh";
    user.textColor = [UIColor blackColor];
    user.textAlignment = NSTextAlignmentLeft;
    user.font = [UIFont systemFontOfSize:14];
    [self.commentView addSubview:user];
    
    UILabel *comment = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, screenWidth, 20)];
    comment.text = @"衣服不错，很舒服！";
    comment.textColor = [UIColor blackColor];
    comment.textAlignment = NSTextAlignmentLeft;
    comment.font = [UIFont systemFontOfSize:12];
    [self.commentView addSubview:comment];
    
    UILabel *commentTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, screenWidth *0.3, 20)];
    commentTime.text = @"2016/5/6";
    commentTime.textColor = [UIColor grayColor];
    commentTime.textAlignment = NSTextAlignmentLeft;
    commentTime.font = [UIFont systemFontOfSize:12];
    [self.commentView addSubview:commentTime];
    
    UILabel *colorCategory = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth *0.3, 100, screenWidth*0.7, 20)];
    colorCategory.text = @"颜色分类：红色；尺寸：28";
    colorCategory.textColor = [UIColor grayColor];
    colorCategory.textAlignment = NSTextAlignmentLeft;
    colorCategory.font = [UIFont systemFontOfSize:12];
    [self.commentView addSubview:colorCategory];
    
    UIButton *allComment = [UIButton buttonWithType:UIButtonTypeCustom];
    allComment.frame = CGRectMake(screenWidth *0.3, 130, screenWidth*0.4, 30);
    [allComment setTitle:@"查看全部评论" forState:UIControlStateNormal];
    [allComment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allComment.layer setBorderColor:[UIColor grayColor].CGColor];
    [allComment.layer setBorderWidth:1];
    [allComment.layer setMasksToBounds:YES];
    [allComment.layer setCornerRadius:5];
    allComment.titleLabel.font = [UIFont systemFontOfSize:13];
    [allComment addTarget:self action:@selector(ClickAllCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentView addSubview:allComment];
    
}

//点击全部评论按钮触发事件
-(void)ClickAllCommentButton:(UIButton *)sender{
    WXCommentController *commnetView = [[WXCommentController alloc]init];
    [self presentViewController:commnetView animated:YES completion:nil];
}
@end
