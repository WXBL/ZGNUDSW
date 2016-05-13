//
//  WXMyInforController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMyInforController.h"
#import "WXHeaderView.h"
#import "WXOrderController.h"
#import "WXUserInforModel.h"
#import "WXManagementController.h"
@interface WXMyInforController ()<WXHeaderViewDelegate>


@property (nonatomic,strong)UIButton *headButton;

@property (nonatomic,strong)UIView *orderView;
@property (nonatomic,strong)UIButton *orderBtn;

@property (nonatomic,strong)UIView *myMoneyView;
@property (nonatomic,strong)UIButton *moneyButton;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *numLabel;

@property (nonatomic,strong)UIImage *picImage;
@end

@implementation WXMyInforController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    
    //添加头部个人信息
    [self addHeaderView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
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

-(void)addHeaderView{

    WXHeaderView *headerView = [[WXHeaderView alloc]init];
    headerView.delegate = self;
    self.headButton = headerView.headerButton;
    self.tableView.tableHeaderView = headerView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserInfor:) name:@"ChangeUserInforNotification" object:nil];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"currentImage.png"];
    
    if (self.picImage==nil) {
        self.picImage= [UIImage imageNamed:@"my_head_default"];
    }
    else{
        self.picImage=[UIImage imageNamed:fullPath];
    }

    [self.headButton setImage:self.picImage forState:UIControlStateNormal];
    
}

-(void)changeUserInfor:(NSNotification *)notification{
    NSDictionary *userDictionary=[notification userInfo];
    
    self.picImage=[userDictionary objectForKey:@"UserPic"];
    
    
    //    [self addContents];
}

- (void)headerView:(UIView *)headerView didClickButton:(UIButton *)button{
    if (button.tag == 0) {
        [self ClickHeadImageBtn:button];
    }else if (button.tag ==1){
        [self ClickProductBtn:button];
    }else if (button.tag == 2){
        [self ClickShopButton:button];
    }else if(button.tag ==3){
        [self ClickScannedButton:button];
    }else if(button.tag ==4){
        [self ClickManagementButton:button];
    }else if(button.tag ==5){
        [self ClickHeadImageBtn:button];
    }else{
        [self ClickMbtypeBtn:button];
    }
    
}

#pragma mark 点击会员按钮
-(void)ClickMbtypeBtn:(UIButton *)sender{
    
}

#pragma mark -点击头像
-(void)ClickHeadImageBtn:(UIButton *)sender{
    WXManagementController *managementController = [[WXManagementController alloc]init];
    [self presentViewController:managementController animated:YES completion:nil];
}

#pragma mark - 点击关注商品，店铺，浏览记录三个按钮触发事件
-(void)ClickProductBtn:(UIButton *)sender{
    
}

-(void)ClickShopButton:(UIButton *)sender{
    
}

-(void)ClickScannedButton:(UIButton *)sender{
    
}

#pragma mark - 账户管理
-(void)ClickManagementButton:(UIButton *)sender{
    WXManagementController *managementViewController = [[WXManagementController alloc]init];
    [self presentViewController:managementViewController animated:YES completion:nil];
}



#pragma mark - tableview dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else if (section ==1){
        return 2;
    }
    return 2;
    //    return self.messageArray.count;
}

/**
 * section底部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

/**
 * section顶部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 15;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            cell.textLabel.text = @"我的订单";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            [self showOrderContent];
            [cell addSubview:self.orderView];
            
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的钱包";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else{
            [self myMoneyInfor];
            [cell addSubview:self.myMoneyView];
        }
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的服务";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    return cell;
}


#pragma mark -tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

        if (indexPath.row == 0) {
            return 50;
        }else{
            return 80;
        }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加待付款、待收货、待评价、退货／退款
-(void)showOrderContent{
    self.orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 80)];
    self.orderView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i<4; i++) {
        self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.orderBtn.frame = CGRectMake(i * screenWidth *0.25, 0, screenWidth *0.25, 80);
        self.orderBtn.tag = i+1;
        switch (i) {
            case 0:
                [self.orderBtn setTitle:@"待付款" forState:UIControlStateNormal];
                break;
            case 1:
                [self.orderBtn setTitle:@"待收货" forState:UIControlStateNormal];
                break;
            case 2:
                [self.orderBtn setTitle:@"待评价" forState:UIControlStateNormal];
                break;
            case 3:
                [self.orderBtn setTitle:@"退货／退款" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        [self.orderBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.orderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.orderView addSubview:self.orderBtn];
        
        
        [self.orderBtn addTarget:self action:@selector(ClickOrderBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
   
   
}

-(void)ClickOrderBtn:(UIButton *)sender{
    
    WXOrderController *order = [[WXOrderController alloc]init];
    [self presentViewController:order animated:YES completion:nil];
}

-(void)myMoneyInfor
{
//    WXUserInforModel *userInforModel = [[WXUserInforModel alloc]init];
    
    
    self.myMoneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 80)];
    self.myMoneyView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<3; i++) {
        self.moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moneyButton.frame = CGRectMake(i * screenWidth /3, 0, screenWidth/3, 80);
        self.moneyButton.tag = i+1;
        
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.moneyButton.frame.size.width, self.moneyButton.frame.size.height/2-5)];
        self.numLabel.textColor = [UIColor blackColor];
        self.numLabel.font = [UIFont systemFontOfSize:15];
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        
        self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.moneyButton.frame.size.height/2-5, self.moneyButton.frame.size.width, self.myMoneyView.frame.size.height/2-5)];
        self.moneyLabel.textColor = [UIColor grayColor];
        self.moneyLabel.font = [UIFont systemFontOfSize:14];
        self.moneyLabel.textAlignment = NSTextAlignmentCenter;
        
        switch (i) {
            case 0:
//                self.numLabel.text = userInforModel.balance;
                self.numLabel.text = @"0.00";
                self.moneyLabel.text = @"账户余额";
                break;
            case 1:
//                self.numLabel.text = userInforModel.coupon;
                self.numLabel.text = @"1";
                self.moneyLabel.text = @"优惠券";
                break;
            case 2:
//                self.numLabel.text = userInforModel.gold_coin;
                self.numLabel.text = @"0";
                self.moneyLabel.text = @"金币";
                break;
                
            default:
                break;
        }
        [self.moneyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.moneyButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.myMoneyView addSubview:self.moneyButton];
        
        [self.moneyButton addSubview:self.moneyLabel];
        [self.moneyButton addSubview:self.numLabel];
        
        [self.moneyButton addTarget:self action:@selector(ClickMoneyBtn:) forControlEvents:UIControlEventTouchUpInside];

    }
}

-(void)ClickMoneyBtn:(UIButton *)sender{
    
}

@end
