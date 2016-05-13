//
//  WXCommentController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCommentController.h"
#import "WXTopView.h"
#import "WXCommentTableViewCell.h"
#import "MBProgressHUD.h"
#import "WXBuyCartController.h"
@interface WXCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *buyCartView;
@property (nonatomic,strong)UITableView *commentTableView;

@property (nonatomic,strong)NSMutableArray *commentArray;

@end

@implementation WXCommentController

#pragma mark -懒加载
-(NSMutableArray *)statusArray
{
    if (!_commentArray) {
        
        self.commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.commentArray = [NSMutableArray array];
    
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"商品评论"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    UIButton *buyCart = [UIButton buttonWithType:UIButtonTypeCustom];
    buyCart.frame = CGRectMake(screenWidth -50, 10, 50, 40);
    [buyCart setImage:[UIImage imageNamed:@"detailBar_cart_press"] forState:UIControlStateNormal];
    [buyCart addTarget:self action:@selector(ClickBuyCartButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:buyCart];
    
    [self addTableView];
    [self addbuyCart];

}

/**
 * 添加tableview到view上
 */
-(void)addTableView{
    
    self.commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth - 90) style:UITableViewStylePlain];
    self.commentTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    self.commentTableView.tableFooterView = [[UIView alloc]init];
    //隐藏UITableViewCell的分隔线
    [self.commentTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview: self.commentTableView];
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
    [store setTitle:@"店铺" forState:UIControlStateNormal];
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

//点击购物车按钮触发事件
-(void)ClickBuyCartButton:(UIButton *)sender{
    WXBuyCartController *buyCartViewController = [[WXBuyCartController alloc]init];
    [self presentViewController:buyCartViewController animated:YES completion:nil];
}

/**
 * 即成刷新控件
 */
-(void)setDownRefresh
{
    //1,添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.commentTableView addSubview:control];
    
    //2.马上进入刷新状态，（仅仅显示刷新状态，并不会触发UIControlEventValueChange方法）
    [control beginRefreshing];
    
    //3.马上加载数据
    [self refreshStateChange:control];
}

/**
 * UIRefreshControl进入刷新状态：加载最新的评论数据
 */
-(void)refreshStateChange:(UIRefreshControl *)control
{
    
}

#pragma mark - TableView DataSource数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return self.commentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WXCommentTableViewCell *cell = [WXCommentTableViewCell cellWithTableView:tableView];
    
    //给cell传递模型数据
    cell.statusFrame = self.commentArray[indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 40;
    WXStatusFrame *frame = self.commentArray[indexPath.row];
    return frame.cellHeight;
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

@end
