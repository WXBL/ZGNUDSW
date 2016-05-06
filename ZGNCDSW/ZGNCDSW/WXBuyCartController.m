//
//  WXBuyCartController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXBuyCartController.h"
#import "WXTopView.h"
#import "WXBuyCartTableViewCell.h"
static int num=1;
@interface WXBuyCartController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *buyCartTabelView;

//加入购物车的产品数量

@property (nonatomic,strong)NSString *numStr;

@end

@implementation WXBuyCartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBar];
    
    [self addTableView];
    
    [self addStatement];
}

-(void)setNavBar
{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"购物车"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 10, screenWidth-50, 40);
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}


-(void)addTableView
{
    self.buyCartTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-110) style:UITableViewStylePlain];
    self.buyCartTabelView.delegate = self;
    self.buyCartTabelView.dataSource = self;
    self.buyCartTabelView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.buyCartTabelView];
    
}

//添加结算view
-(void)addStatement{
    UIView *statementView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth-60, screenWidth, 60)];
    statementView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statementView];
    
    UIButton *chooseAll = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseAll.frame = CGRectMake(50, 0, 50, statementView.frame.size.height);
    [chooseAll setTitle:@"全选" forState:UIControlStateNormal];
    [chooseAll setTitleColor:[UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1] forState:UIControlStateNormal];
    [statementView addSubview:chooseAll];
    
    UIButton *statement = [UIButton buttonWithType:UIButtonTypeCustom];
    statement.frame = CGRectMake(screenWidth*0.8, 0, screenWidth*0.2,  statementView.frame.size.height);
    statement.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    [statement setTitle:@"结算" forState:UIControlStateNormal];
    [statement setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [statementView addSubview:statement];
    
    UILabel *totalled = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, 0, screenWidth*0.15 , statementView.frame.size.height/2)];
    totalled.text = @"总计：";
    totalled.textColor = [UIColor grayColor];
    totalled.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:totalled];
    
    UILabel *totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*0.65, 0, screenWidth*0.15 , statementView.frame.size.height/2)];
    totalPrice.text = @"$15.00";
    totalPrice.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    totalPrice.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:totalPrice];
    
    UILabel *luggage = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, statementView.frame.size.height/2, screenWidth*0.3 , statementView.frame.size.height/2)];
    luggage.text = @"不含运费";
    luggage.textColor = [UIColor grayColor];
    luggage.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:luggage];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"buyCartcell";
    WXBuyCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[WXBuyCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    [cell.productImage setImage:[UIImage imageNamed:@"news_list1"]];
    cell.titleLabel.text = @"alskjdflkasdjfl";
    cell.priceLabel.text = @"¥10";
    cell.buyNum.text = @"＊1";
    
    cell.reduceButton.tag = 1;
    [cell.reduceButton addTarget:self action:@selector(ClickReduceButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.addButton.tag = 2;
    [cell.addButton addTarget:self action:@selector(ClickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell.buyNumLabel.text = self.numStr;
    
    //点击cell时不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//点击减少数量按钮触发事件
-(void)ClickReduceButton:(UIButton *)sender
{
 
   
}

//点击增加数量按钮触发事件
-(void)ClickAddButton:(UIButton *)sender{
    
    
    num++;
    NSString *numStr = [NSString stringWithFormat:@"%d",num];
    self.numStr = numStr;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
