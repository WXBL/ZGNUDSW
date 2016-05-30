//
//  WXGZProductViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXGZProductViewController.h"
#import "WXGZProductTableViewCell.h"
#import "WXTopView.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "WXFarmDetailViewController.h"
#import "WXCollectionModel.h"
#import "MDDataBaseUtil.h"
#import "WXProductModel.h"
#import "WXImageModel.h"
#define GET_COLLECTIONLIST_URL @""
#define DELETE_COLLECTION_URL @""
@interface WXGZProductViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)WXTopView *topView;
@property(nonatomic,strong)NSMutableArray *collectionArr;
@property(nonatomic,strong)AFHTTPRequestOperationManager *AFMGR;
@end

@implementation WXGZProductViewController
-(NSMutableArray *)collectionArr{
    if (!_collectionArr) {
        self.collectionArr=[[NSMutableArray alloc] init];
    }
    return _collectionArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.AFMGR=[AFHTTPRequestOperationManager manager];
    [self addNavbar];
    [self addTableView];
    [self setCollectionProductData];
}
-(void)setCollectionProductData{
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,GET_COLLECTIONLIST_URL];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"User_ID"]=[MDDataBaseUtil userID];
    [self.AFMGR GET:path parameters:params success:^(AFHTTPRequestOperation *operation,NSArray *responseObject){
        self.collectionArr=[[[WXCollectionModel alloc] init] getCollectionListWithArrayJSON:responseObject];
        [self.tableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
-(void)addNavbar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"我的收藏"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView = topView;

}

-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), screenWidth, screenHeigth - CGRectGetHeight(self.topView.frame)) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:self.tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return 3;
    return self.collectionArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    
    WXGZProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil){
        cell = [[WXGZProductTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    WXCollectionModel *collection=[self.collectionArr objectAtIndex:indexPath.row];
    WXProductModel *product=collection.Goods;
    WXImageModel *img=[product.Goods_Image firstObject];
    cell.proImage.image=[UIImage imageNamed:img.Image_Name];
    cell.titleLabel.text=product.Goods_Name;
    cell.priceLabel.text=product.Goods_Price;
    
//    [cell.proImage setImage:[UIImage imageNamed:@"headurl"]];
//    cell.titleLabel.text = @"asdfasdfasd";
//    cell.priceLabel.text = @"¥30";
    cell.cancleConcern.tag=indexPath.row;
    [cell.cancleConcern addTarget:self action:@selector(cancelColection:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.cancleConcern bringSubviewToFront:cell];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}
-(void)cancelColection:(UIButton *)btn{
    NSLog(@"btn");
    WXCollectionModel *collection=[self.collectionArr objectAtIndex:btn.tag];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,DELETE_COLLECTION_URL];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"Collection_ID"]=collection.Collection_ID;
    [self.AFMGR GET:path parameters:params success:^(AFHTTPRequestOperation *operation,NSString *responseObject){
        if ([responseObject isEqualToString:@"success"]) {
            [self.collectionArr removeObjectAtIndex:btn.tag];
            [self.tableView reloadData];
        }
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"cell");
    WXFarmDetailViewController *farmDetailVC=[[WXFarmDetailViewController alloc] init];
    WXCollectionModel *collection=[self.collectionArr objectAtIndex:indexPath.row];
    farmDetailVC.theProduct=collection.Goods;
    [self presentViewController:farmDetailVC animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
