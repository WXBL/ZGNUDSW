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


}

/**
 * 添加tableview到view上
 */
-(void)addTableView{
    
    self.commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth) style:UITableViewStylePlain];
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


-(void)ClickServiceButton:(UIButton *)sender{
    
}

-(void)ClickStoreButton:(UIButton *)sender{
    
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
