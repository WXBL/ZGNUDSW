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
#import "WXCartTool.h"
#import "WXShoppingModel.h"
#import "Util.h"
#import "Header.h"
#import "ShoppingBtn.h"
static int num=1;
@interface WXBuyCartController ()<UITableViewDelegate,UITableViewDataSource,WXCartToolDelegate>

@property (nonatomic,strong)UITableView *buyCartTabelView;

@property (nonatomic,strong)NSMutableArray *shoppingArray;

@property (nonatomic,strong)UIView *editView;
@property(nonatomic,strong)UIButton *editButton ;

//加入购物车的产品数量

@property (nonatomic,strong)NSString *numStr;

@end

@implementation WXBuyCartController

#pragma mark- 懒加载
-(void)setShoppingArray:(NSMutableArray *)shoppingArray
{
    if (_shoppingArray != shoppingArray) {
        _shoppingArray = shoppingArray;
        
        [self.buyCartTabelView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavBar];
    
    [self addTableView];
    
    [self addStatement];
    
    self.numStr = @"1";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
    [self.buyCartTabelView reloadData];
}

-(void)viewWillLayoutSubviews
{
    if ([self.buyCartTabelView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.buyCartTabelView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.buyCartTabelView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)setNavBar
{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"购物车"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame = CGRectMake(screenWidth-50, 10,50 , 40);
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.editButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.editButton addTarget:self action:@selector(ClickEditButton:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.editButton];
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
    WXCartTool *toolBar = [[WXCartTool alloc]init];
    toolBar.delegate = self;
    
    [self.view addSubview:toolBar];
}


//点击编辑按钮触发事件
-(void)ClickEditButton:(UIButton *)sender{
    
    
    [self.buyCartTabelView reloadData];
   
    
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
        
        ShoppingBtn *collocationBtn = [[ShoppingBtn alloc]initWithFrame:CGRectMake(0, 0, 55, 40)];
        collocationBtn.tag = section;
        [collocationBtn addTarget:section action:@selector(CollocationBtn:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:collocationBtn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 60, 20)];
        label.backgroundColor = BACKGROUNDCOLOR;
        label.textColor = [UIColor whiteColor];
        label.text = @"搭配购";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.0];
        [view addSubview:label];
        [Util makeCorner:3 view:label];
        
        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake([Util ReturnViewFrame:label Direction:@"X"] + 10, 10, SCREEN_WIDTH - ([Util ReturnViewFrame:label Direction:@"X"] + 10) , 20)];
        subLabel.textColor = [UIColor grayColor];
        subLabel.textAlignment = NSTextAlignmentLeft;
        subLabel.font = [UIFont systemFontOfSize:12.0];
        [view addSubview:subLabel];
        
        //用来判断 section Header 是否被选中
        if (headModel.headClickState == 1) {
            
            [collocationBtn setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
            
        }else{
            
            [collocationBtn setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
            
        }
        
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
        
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, SCREEN_WIDTH -55, 40)];
        priceLabel.textColor = BACKGROUNDCOLOR;
        priceLabel.text = @"小计:￥00.00";
        priceLabel.font = [UIFont systemFontOfSize:12.0];
        [view addSubview:priceLabel];
        
        
//        //享受优惠力度
//        if (forModel.headPriceDict) {
//            
//            priceLabel.text = [NSString stringWithFormat:@"%@%@",forModel.headPriceDict[@"footerTitle"],forModel.headPriceDict[@"footerMinus"]];
//            [Util setUILabel:priceLabel Data:forModel.headPriceDict[@"footerTitle"] SetData:forModel.headPriceDict[@"footerMinus"] Color:[UIColor grayColor] Font:12.0 Underline:NO];
//        }
        
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
        bottomview.backgroundColor = UIColorRGBA(238, 238, 238, 1);
        [view addSubview:bottomview];
        [Util setFoursides:bottomview Direction:@"top" sizeW:SCREEN_WIDTH];
        return  view;
        
    }else{
        
        UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
        bottomview.backgroundColor = UIColorRGBA(238, 238, 238, 1);
        return bottomview;
    }
    
    
    return nil ;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return _shoppingArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    WXShoppingModel *model = _shoppingArray[section];
    return model.headCellArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"buyCartcell";
    WXBuyCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[WXBuyCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.editView.hidden=NO;
    }
    
    [cell.productImage setImage:[UIImage imageNamed:@"news_list1"]];
    cell.titleLabel.text = @"alskjdflkasdjfl";
    cell.priceLabel.text = @"¥10";
    cell.buyNum.text = @"＊1";
    
    cell.reduceButton.tag = 1;
    [cell.reduceButton addTarget:self action:@selector(ClickReduceButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(ClickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    cell.buyNumLabel.text = self.numStr;
    
    self.editView = cell.editView;

    if (self.editView.hidden) {
        self.editView.hidden=NO;
        [self.editButton setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        self.editView.hidden=YES;
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    
    //点击cell时不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
   
}

//点击减少数量按钮触发事件
-(void)ClickReduceButton:(UIButton *)sender
{
    if (num>1) {
        num--;
        self.numStr = [NSString stringWithFormat:@"%d",num];
        
        [self.buyCartTabelView reloadData];
    }
    
   
}

//点击增加数量按钮触发事件
-(void)ClickAddButton:(UIButton *)sender{
    
    
    num++;
    self.numStr = [NSString stringWithFormat:@"%d",num];
 
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
