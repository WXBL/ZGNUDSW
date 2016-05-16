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
#import "WXImageModel.h"
#import "WXMerchantModel.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "MDDataBaseUtil.h"
#import "WXColorModel.h"
#import "WXSizeModel.h"
#define PRODUCT_IS_COLLECTION @""
#define ADD_COLLECTION_PRODUCT @""
#define CANCEL_COLLECTION_PRODUCT @""
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

@property(nonatomic,copy)NSString *str;
@property(nonatomic,assign)CGFloat height;
@end

@implementation WXFarmDetailViewController
-(NSMutableArray *)productImgArr{
    if (!_productImgArr) {
        self.productImgArr=[NSMutableArray array];
    }
    return _productImgArr;
}
-(NSMutableArray *)sizeArray{
    if (!_sizeArray) {
        self.sizeArray=[NSMutableArray array];
    }
    return _sizeArray;
}
-(NSString *)str{
    if (!_str) {
        self.str=[NSString string];
    }
    return _str;
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
-(void)viewWillAppear:(BOOL)animated{
    [self.sizeTableView reloadData];
    [self.tableView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated{
    AFHTTPRequestOperationManager *AFMgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param=[NSMutableDictionary dictionary];
    NSString *path=@"";
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"oldCollectionProduct"]&&![[NSUserDefaults standardUserDefaults] objectForKey:@"saveTheProduct"]) {
//         取消收藏
        param[@"Collection_ID"]=[[NSUserDefaults standardUserDefaults]objectForKey:@"oldCollectionProduct"];
        path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,CANCEL_COLLECTION_PRODUCT];
        
        
    }else if(![[NSUserDefaults standardUserDefaults]objectForKey:@"oldCollectionProduct"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"saveTheProduct"]){
//        加入收藏
        param[@"User_ID"]=[MDDataBaseUtil userID];
        param[@"Goods_ID"]=self.theProduct.Goods_ID;
        path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,ADD_COLLECTION_PRODUCT];
    }
    
    [AFMgr POST:path parameters:param success:^(AFHTTPRequestOperation *operation,NSString *responseObject){
        NSLog(@"%@",responseObject);
            }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
    }];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oldCollectionProduct"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saveTheProduct"];

}
-(void)theProductIsCellection{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"Goods_ID"]=self.theProduct.Goods_ID;
    
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,PRODUCT_IS_COLLECTION];
    [mgr POST:path parameters:params success:^(AFHTTPRequestOperation *operation,NSString *responseObject){
        if ([responseObject isEqualToString:self.theProduct.Goods_ID]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.theProduct forKey:@"oldCollectionProduct"];
            [[NSUserDefaults standardUserDefaults] setObject:self.theProduct forKey:@"saveTheProduct"];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        
        hud.labelText=@"网络请求失败";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2];
    }];
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
    self.tableView.tag=1;
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
    
    UIButton *store = [UIButton buttonWithType:UIButtonTypeCustom];
    store.frame = CGRectMake(0, 0, screenWidth/6, 40);
    //    [keep setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [store setTitle:@"商家" forState:UIControlStateNormal];
    [store setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [store setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    store.titleLabel.font = [UIFont systemFontOfSize:14];
    [store.layer setBorderColor:[UIColor colorWithWhite:0.9 alpha:1].CGColor];
    [store.layer setBorderWidth:0.5];
    [store.layer setMasksToBounds:YES];
    [store addTarget:self action:@selector(ClickStoreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:store];
    
    UIButton *keep = [UIButton buttonWithType:UIButtonTypeCustom];
    keep.frame = CGRectMake(CGRectGetMaxX(store.frame), 0, screenWidth/6, 40);
//    [keep setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [keep setTitle:@"收藏" forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [keep setTitle:@"已收藏" forState:UIControlStateSelected];
    [keep setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"saveTheProduct"]) {
        keep.selected=YES;
    }else{
        keep.selected=NO;
    }

    
    [keep setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [keep setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    keep.titleLabel.font = [UIFont systemFontOfSize:14];
    [keep.layer setBorderColor:[UIColor colorWithWhite:0.9 alpha:1].CGColor];
    [keep.layer setBorderWidth:0.5];
    [keep.layer setMasksToBounds:YES];
    [keep addTarget:self action:@selector(ClickKeepButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:keep];
    
    UIButton *addbuyCart = [UIButton buttonWithType:UIButtonTypeCustom];
    addbuyCart.frame = CGRectMake(CGRectGetMaxX(keep.frame), 0, screenWidth/3, 40);
    addbuyCart.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    [addbuyCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addbuyCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addbuyCart.titleLabel.font = [UIFont systemFontOfSize:16];
    [addbuyCart addTarget:self action:@selector(addBuyCartButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCartView addSubview:addbuyCart];
    
    UIButton *buyLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    buyLabel.frame = CGRectMake(CGRectGetMaxX(addbuyCart.frame), 0, screenWidth/3, 40);
    buyLabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.2 blue:0.3 alpha:1];
    [buyLabel setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyLabel.titleLabel.font = [UIFont systemFontOfSize:16];
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
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"saveTheProduct"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saveTheProduct"];
        hud.labelText=@"取消收藏";
        
        sender.selected=NO;
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:self.theProduct forKey:@"saveTheProduct"];
        hud.labelText = @"收藏成功！";
        sender.selected=YES;
    }
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
    self.productImgArr=self.theProduct.Goods_Image;
    
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
    WXImageModel *imageModel=[[WXImageModel alloc] init];
    // 1. 循环创建5个UIImageView添加到ScrollView中
    for (int i = 0; i < self.productImgArr.count; i++) {
        // 创建一个UIImageView
        self.imageView = [[UIImageView alloc] init];
        
        // 设置UIImageView中的图片
        imageModel=[self.productImgArr objectAtIndex:i];
        self.imageView.image = [UIImage imageNamed:imageModel.Image_ur];
        
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
        return 4;
    }
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==1) {
        static NSString *cellStr = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        
        
        
        if (indexPath.row == 0) {
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 100)];
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
            size.text = @"选择类型";
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
    }else if(tableView.tag==2){
        static NSString *cellStr = @"sizecell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
//        cell.textLabel.text = @"sdf";
        UILabel *nameLbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 80, CGRectGetHeight(cell.frame))];
//        nameLbl.backgroundColor=[UIColor grayColor];
        nameLbl.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:nameLbl];
        UILabel *contentLbl=[[UILabel alloc] init];
        contentLbl.frame=CGRectMake(CGRectGetMaxX(nameLbl.frame), CGRectGetMinY(nameLbl.frame)+3, screenWidth-CGRectGetMaxX(nameLbl.frame)-5, self.height+10);
        NSLog(@"%lf",CGRectGetHeight(cell.frame));
//        contentLbl.backgroundColor=[UIColor lightGrayColor];
        contentLbl.numberOfLines=0;
        [cell.contentView addSubview:contentLbl];
        WXTypeModel *type=self.theProduct.Goods_Type;
        NSMutableArray *size=self.theProduct.Goods_Size;
        NSMutableArray *color=self.theProduct.Goods_Color;
        if (indexPath.row==0) {
            nameLbl.text=@"名称";
            contentLbl.text=self.theProduct.Goods_Name;
        }else if (indexPath.row==1){
            nameLbl.text=@"类型";
            contentLbl.text=type.Type_Name;
        }else if(indexPath.row==2){
            nameLbl.text=@"大小";
            NSString *str;
            for (int i=0; i<size.count; i++) {
                str=[str stringByAppendingString:((WXSizeModel *)[size objectAtIndex:i]).Goods_Size];
            }
            contentLbl.text=str;
        }else if(indexPath.row==3){
            nameLbl.text=@"颜色";
//            NSString *str;
            for (int i=0; i<color.count; i++) {
                self.str=[self.str stringByAppendingString:[NSString stringWithFormat:@"%@     ",((WXColorModel *)[color objectAtIndex:i]).Goods_Color]];
                
            }
            contentLbl.text=self.str;
            
             NSLog(@"%lf",self.height);
            [contentLbl sizeToFit];
            contentLbl.backgroundColor=[UIColor lightGrayColor];

            
            
        }
        return cell;
    }
    return nil;
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
            return 110;
        }else if(indexPath.row == 3){
            return 100;
        }else{
            return 40;
        }
    }else{
        
//        return 40;
        if (indexPath.row==3) {
            CGSize size=CGSizeMake(screenWidth-90, 200);
            self.height=[self.str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            return self.height;
        }
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
    
    self.sizeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, productSize.frame.size.height, screenWidth, sizeView.frame.size.height * 0.8)];
    self.sizeTableView.delegate = self;
    self.sizeTableView.dataSource = self;
    self.sizeTableView.tag=2;
    self.sizeTableView.allowsSelection=NO;
    self.sizeTableView.bounces=NO;
    self.sizeTableView.backgroundColor = [UIColor whiteColor];
    self.sizeTableView.tableFooterView = [[UIView alloc]init];
    [self.sizeView addSubview:self.sizeTableView];
    
    
    UIButton *finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    finishButton.frame = CGRectMake(0, sizeView.frame.size.height-sizeView.frame.size.height*0.1, screenWidth, sizeView.frame.size.height*0.1);
    [finishButton setBackgroundColor: [UIColor colorWithRed:0.4 green:0.7 blue:0.3 alpha:1]];
    [finishButton setTitle:@"关闭" forState:UIControlStateNormal];
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
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth, 50)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = self.theProduct.Goods_Name;
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 0;
    [self.cellBgView addSubview:titleLabel];
    
//    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(screenWidth *0.85, 5, 1, 45)];
//    lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
//    [self.cellBgView addSubview:lineView];
//    
//    //分享
//    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    shareButton.frame = CGRectMake(screenWidth * 0.9, 2, screenWidth * 0.1, 30);
//    [shareButton setImage:[UIImage imageNamed:@"share_it"] forState:UIControlStateNormal];
//    [shareButton addTarget:self action:@selector(ClickShareButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.cellBgView addSubview:shareButton];
//    
//    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth * 0.9, 35, screenWidth *0.1, 20)];
//    shareLabel.text = @"分享";
//    shareLabel.font = [UIFont systemFontOfSize:11];
//    shareLabel.textAlignment = NSTextAlignmentCenter;
//    shareLabel.textColor = [UIColor blackColor];
//    [self.cellBgView addSubview:shareLabel];
    
    

    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame), 50, 20)];
    price.textColor = [UIColor grayColor];
    price.text = @"单价:";
    price.textAlignment = NSTextAlignmentLeft;
    price.font = [UIFont systemFontOfSize:14];
    [self.cellBgView addSubview:price];
    //价格
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(price.frame), titleLabel.frame.size.height, screenWidth * 0.2, 20)];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.text = [NSString stringWithFormat:@"¥ %@",self.theProduct.Goods_Buy_Num];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:16];
    [self.cellBgView addSubview:priceLabel];
    
    //快递费，销量，卖家地址
    UILabel *postageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(price.frame)+5, 50, 20)];
    postageLabel.textColor = [UIColor grayColor];
    postageLabel.text = @"快递：";
    postageLabel.textAlignment = NSTextAlignmentLeft;
    postageLabel.font = [UIFont systemFontOfSize:14];
    [self.cellBgView addSubview:postageLabel];
    
    UILabel *postage = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(postageLabel.frame), CGRectGetMinY(postageLabel.frame), screenWidth/3-60, 20)];
    postage.textColor = [UIColor grayColor];
    postage.text = @"免费";
    postage.textAlignment = NSTextAlignmentLeft;
    postage.font = [UIFont systemFontOfSize:14];
    [self.cellBgView addSubview:postage];
    
    UILabel *saleNum = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /3,  CGRectGetMinY(postageLabel.frame), screenWidth/3, 20)];
    saleNum.textColor = [UIColor grayColor];
    saleNum.text = [NSString stringWithFormat:@"月销%@笔",self.theProduct.Goods_Average];
    saleNum.textAlignment = NSTextAlignmentCenter;
    saleNum.font = [UIFont systemFontOfSize:14];
    [self.cellBgView addSubview:saleNum];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /3 *2,  CGRectGetMinY(postageLabel.frame), screenWidth /3-10, 20)];
    address.textColor = [UIColor grayColor];
    WXMerchantModel *merchant=self.theProduct.Merchant;
    address.text = merchant.Company_Address;
    address.textAlignment = NSTextAlignmentRight;
    address.font = [UIFont systemFontOfSize:14];
    [self.cellBgView addSubview:address];
    
}

-(void)ClickShareButton:(UIButton *)sender
{
    NSArray *imageArray = self.theProduct.Goods_Image;
    
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
    
    
//    UILabel *user = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, screenWidth*0.3, 30)];
//    user.text = @"jwh";
//    user.textColor = [UIColor blackColor];
//    user.textAlignment = NSTextAlignmentLeft;
//    user.font = [UIFont systemFontOfSize:14];
//    [self.commentView addSubview:user];
//    
//    UILabel *comment = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, screenWidth, 20)];
//    comment.text = @"衣服不错，很舒服！";
//    comment.textColor = [UIColor blackColor];
//    comment.textAlignment = NSTextAlignmentLeft;
//    comment.font = [UIFont systemFontOfSize:12];
//    [self.commentView addSubview:comment];
//    
//    UILabel *commentTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, screenWidth *0.3, 20)];
//    commentTime.text = @"2016/5/6";
//    commentTime.textColor = [UIColor grayColor];
//    commentTime.textAlignment = NSTextAlignmentLeft;
//    commentTime.font = [UIFont systemFontOfSize:12];
//    [self.commentView addSubview:commentTime];
//    
//    UILabel *colorCategory = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth *0.3, 100, screenWidth*0.7, 20)];
//    colorCategory.text = @"颜色分类：红色；尺寸：28";
//    colorCategory.textColor = [UIColor grayColor];
//    colorCategory.textAlignment = NSTextAlignmentLeft;
//    colorCategory.font = [UIFont systemFontOfSize:12];
//    [self.commentView addSubview:colorCategory];
    
    UIButton *allComment = [UIButton buttonWithType:UIButtonTypeCustom];
    allComment.frame = CGRectMake(screenWidth *0.3, CGRectGetMaxY(userComment.frame), screenWidth*0.4, 30);
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
