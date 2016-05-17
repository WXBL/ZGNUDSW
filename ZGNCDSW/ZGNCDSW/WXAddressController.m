//
//  WXAddressController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddressController.h"
#import "WXTopView.h"
#import "WXAddAddressViewController.h"
#import "WXAddressTableViewCell.h"
#import "WXAddressModel.h"
#import "WXAddressFrame.h"
@interface WXAddressController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)NSMutableArray *addressArray;
@end

@implementation WXAddressController

#pragma mark -懒加载
-(NSMutableArray *)statusArray
{
    if (!_addressArray) {
        self.addressArray = [NSMutableArray array];
    }
    return _addressArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.addressArray = [NSMutableArray array];
//    WXAddressModel *model=[[WXAddressModel alloc] init];
//    model.addName=@"asd";
//    model.addNumber=@"1231";
//    model.Specific_Address = @"tinajinshiwuqingqu";
//    [self.addressArray addObject:model];
    [self addNavBar];
    
    [self addTableView];
    
    [self addAddressButton];
    
    
}


-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"收货地址"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView = topView;
}

-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height, screenWidth, screenHeigth-self.topView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    

    [self.view addSubview:self.tableView];
}

-(void)addAddressButton{
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth-50, screenWidth, 50)];
    addressView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addressView];
    
    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addressBtn.frame = CGRectMake(addressView.frame.size.width *0.2, addressView.frame.size.height*0.2, addressView.frame.size.width *0.6,  addressView.frame.size.height*0.6);
    addressBtn.backgroundColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.5 alpha:1];
    [addressBtn setTitle:@"添加地址" forState:UIControlStateNormal];
    [addressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addressBtn addTarget:self action:@selector(ClickAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [addressView addSubview:addressBtn];
}

-(void)ClickAddressBtn:(UIButton *)sender{
    WXAddAddressViewController *address = [[WXAddAddressViewController alloc]init];
    [self presentViewController:address animated:YES completion:nil];
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

#pragma mark tableView -dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
//    return self.addressArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WXAddressTableViewCell *cell = [WXAddressTableViewCell cellWithTableView:tableView];
    
//
//    cell.addressFrame = self.addressArray[indexPath.row];
    
    return cell;
    

}

#pragma mark tableView -delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    WXAddressFrame *frame = self.addressArray[indexPath.row];
    
    return 130;
 
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
