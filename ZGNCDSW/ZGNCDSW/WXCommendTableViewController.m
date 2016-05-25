//
//  WXCommendTableViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCommendTableViewController.h"
#import "WXCommendTableViewCell.h"
#import "WXTopView.h"
#import "WXShoppingModel.h"
#import "Util.h"
@interface WXCommendTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)NSMutableArray *shoppingArray;
@property (nonatomic,strong)NSMutableArray *commendArray;

@end

@implementation WXCommendTableViewController

#pragma mark- 懒加载
-(void)setShoppingArray:(NSMutableArray *)shoppingArray
{
    if (_shoppingArray != shoppingArray) {
        _shoppingArray = shoppingArray;
        
        [self.tableView reloadData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBar];
    
    [self addTableView];
}

-(void)addNavBar{
    
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"待评价"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView = topView;
}

-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height, screenWidth, screenHeigth-self.topView.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

-(void)viewWillLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.shoppingArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    WXShoppingModel *headModel = _shoppingArray[section];

    return headModel.headCellArray.count;
    
}

#pragma mark 分割线去掉左边15个像素
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    WXShoppingModel *headModel = _shoppingArray[section];
    if (headModel.headState ==1) {
        return 40;
    }else if (headModel.headState == 2){
        return 40;
    }else{
        return 0.00001;
    }
}

#pragma mark头部视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WXShoppingModel *headModel = _shoppingArray[section];
    if (headModel.headState == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        [Util setFoursides:view Direction:@"top" sizeW:screenWidth];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 60, 20)];
        label.backgroundColor = [UIColor redColor];
        label.textColor = [UIColor whiteColor];
        label.text = @"搭配购";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.0];
        [view addSubview:label];
        [Util makeCorner:3 view:label];
        
       
        
        
        return view;
        
    }else if (headModel.headState == 2){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        view.backgroundColor = [UIColor greenColor];
        return view;
    }
    return nil;
}

#pragma mark 底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    WXShoppingModel *forModel = _shoppingArray[section];
    
    if (forModel.headState == 1) {
        
        return 50;
        
    }else {
        
        return 10;
    }
    
}

#pragma mark底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    WXShoppingModel *forModel = _shoppingArray[section];
    if (forModel.headState == 1) {
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, screenWidth -55, 40)];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.text = @"小计:￥00.00";
        priceLabel.font = [UIFont systemFontOfSize:12.0];
        [view addSubview:priceLabel];
        
        
        
        
//        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
//        bottomview.backgroundColor = UIColorRGBA(238, 238, 238, 1);
//        [view addSubview:bottomview];
//        [Util setFoursides:bottomview Direction:@"top" sizeW:SCREEN_WIDTH];
//        return  view;
//        
//    }else{
//        
//        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
//        bottomview.backgroundColor = UIColorRGBA(238, 238, 238, 1);
//        return bottomview;
//    }
    
    }
    return nil ;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    WXCommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[WXCommendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
   
    [cell.productImage setImage:[UIImage imageNamed:@"headurl"]];
    return cell;
}

#pragma mark -Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
