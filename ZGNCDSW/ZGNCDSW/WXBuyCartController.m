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


@interface WXBuyCartController ()<UITableViewDelegate,UITableViewDataSource,WXCartToolDelegate,WXBuyTableViewCellDelegate>{
    
    NSArray *cellArray;
    
    
    BOOL editbool;
}

@property (nonatomic,assign)BOOL isbool;

@property (nonatomic,strong)UITableView *buyCartTabelView;

@property (nonatomic,strong)NSMutableArray *shoppingArray;

@property (nonatomic,strong)UIView *editView;
@property(nonatomic,strong)UIButton *editButton ;

@property (strong, nonatomic) UIView *naviView;
@property (strong, nonatomic) UIView *bottomView;

@property(nonatomic,strong)UILabel *allPriceLabel;
@property (strong, nonatomic)UILabel *settlementLabel;

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
    self.buyCartTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-110) style:UITableViewStyleGrouped];
    self.buyCartTabelView.delegate = self;
    self.buyCartTabelView.dataSource = self;
    self.buyCartTabelView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.buyCartTabelView];
    
    [self setData];
    
}

//添加结算view
-(void)addStatement{
    WXCartTool *toolBar = [[WXCartTool alloc]init];
    toolBar.delegate = self;
    
    [self.view addSubview:toolBar];
}

-(void)setInit{
    
    _numStr = @"0";
    [Util setFoursides:_bottomView Direction:@"top" sizeW:SCREEN_WIDTH];
    [Util setFoursides:_naviView Direction:@"bottom" sizeW:SCREEN_WIDTH];
    
    
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AllPrice:) name:@"AllPrice" object:nil];
    [Util setUILabel:_allPriceLabel Data:@"总价: " SetData:@"￥0.00" Color:BACKGROUNDCOLOR Font:15 Underline:NO];
    
}

#pragma mark 通知
- (void)AllPrice:(NSNotification *)text{
    
    WXCartTool *cartTool = [[WXCartTool alloc]init];
    cartTool.totalPrice.text = [NSString stringWithFormat:@"%@",text.userInfo[@"allPrice"]];
    
    _numStr= text.userInfo[@"num"];
    
//    [self setTlementLabel];
    [self setAllBtnState:[text.userInfo[@"allState"]  isEqual: @"YES"]?NO:YES];
    
    cellArray =  text.userInfo[@"cellModel"];
}


//#pragma 全选
- (void)AllBtn:(UIButton *)sender {
    
    [self allBtn:!self.isbool];
}


#pragma mark 全选
-(void)setAllBtnState:(BOOL)_bool{
    
    WXCartTool *cartTool = [[WXCartTool alloc]init];
    if (_bool) {
        
        cartTool.chooseAllImage.image = [UIImage imageNamed:@"iconfont-yuanquan"];
        self.isbool = NO;
        
    }else{
        
        cartTool.chooseAllImage.image = [UIImage imageNamed:@"iconfont-zhengque"];
        self.isbool = YES;
    }
}



-(void)setData{
    
    
    NSDictionary *dicts = @{
                            @"item":@[
                                    @{
                                        @"headID":@"10",
                                        @"headState":@1,
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@1,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@1,
                                                    @"ID":@"10",
                                                    },
                                                @{
                                                    
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@1,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@1,
                                                    @"ID":@"11",
                                                    },
                                                @{
                                                    
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@1,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"12",
                                                    },
                                                ]
                                        
                                        },
                                    @{
                                        @"headID":@"11",
                                        @"headState":@1,
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@1,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@1,
                                                    @"ID":@"13",
                                                    },
                                                @{
                                                    
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@1,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"14",
                                                    },
                                                ]
                                        
                                        },
                                    @{
                                        @"headID":@"10",
                                        @"headState":@0,
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@1,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"15",
                                                    },
                                                
                                                ]
                                        
                                        },
                                    @{
                                        @"headID":@"10",
                                        @"headState":@0,
                                        @"headCellArray":@[
                                                @{
                                                    @"imageUrl":@"headurl.png",
                                                    @"title":@"韩版宽松杂色马海毛休闲",
                                                    @"color":@"浅蓝",
                                                    @"size":@"s",
                                                    @"price":@"100.00",
                                                    @"numInt":@1,
                                                    @"inventoryInt":@10,
                                                    @"mustInteger":@0,
                                                    @"ID":@"16",
                                                    },
                                                
                                                ]
                                        
                                        },
                                    
                                    
                                    ]
                            };
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in dicts[@"item"]) {
        
        NSMutableArray *dictarray = [[NSMutableArray alloc] init];
        WXShoppingModel *model = [[WXShoppingModel alloc] initWithShopDict:dict];
        [dictarray addObject:model];
        
        [array addObject:model];
        
    }
    
    self.shoppingArray = array;
    
}



//点击编辑按钮触发事件
-(void)ClickEditButton:(UIButton *)sender{
    
    if (editbool) {
        [self editBtn:editbool];
        editbool = NO;
    }else{
        [self editBtn:editbool];
        editbool = YES;
    }
     [self.editButton setTitle:editbool?@"完成":@"编辑" forState:UIControlStateNormal];
    self.editView.hidden = editbool;
   
   
    
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
        [collocationBtn addTarget:self action:@selector(CollocationBtn:) forControlEvents:UIControlEventTouchDown];
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

#pragma mark 单选
-(void)ShoppingTableViewCell:(WXShoppingCellModel *)model{
    
    WXShoppingModel *headmodel = _shoppingArray[model.section];
    
    int i = 0;
    for (WXShoppingCellModel *cellmodel in headmodel.headCellArray) {
        
        if ( cellmodel.cellClickState == 1) {
            
            i++;
        }
    }
    
    if (i == headmodel.headCellArray.count) {
        
        headmodel.headClickState = 1;
        
    }else{
        
        headmodel.headClickState = 0;
    }
    
    [self CalculationPrice];
    [self.buyCartTabelView reloadData];
}

#pragma mark 分组全选
-(void)CollocationBtn:(UIButton *)sender{
    
    WXShoppingModel *model = _shoppingArray[sender.tag];
    [self RefreshAllCellState:model];
    
    [self CalculationPrice];
    [self.buyCartTabelView reloadData];
}

#pragma mark 刷新cell状态
-(void)RefreshAllCellState:(WXShoppingModel *)model{
    
    if (model.headClickState == 1) {
        
        model.headClickState = 0;
        
        for (WXShoppingCellModel *cellmodel in model.headCellArray) {
            
            cellmodel.cellClickState = 0;
        }
        
    }else{
        
        model.headClickState = 1;
        
        for (WXShoppingCellModel *cellmodel in model.headCellArray) {
            
            cellmodel.cellClickState = 1;
        }
    }
}

#pragma mark 计算价格
-(void)CalculationPrice{
    
    //所有商品的总价
    CGFloat allPrict = 0.0;
    
    
    //用于判断是否全选
    NSMutableArray *allClickArray = [[NSMutableArray alloc] init];
    
    //纪录选中的cellModel;
    NSMutableArray *cellModelArray = [[NSMutableArray alloc] init];
    
    for (WXShoppingModel *model in _shoppingArray) {
        
        //用于判断是否全选，当该数组个数和_shoppingArray个数一样时，说明我选中了全部产品
        if (model.headClickState ==1) {
            
            [allClickArray addObject:[NSString stringWithFormat:@"%ld",(long)model.headClickState]];
        }
        
        //纪录每个分组下面的头部 和 尾部 数据的变化
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
         NSMutableArray *array = [[NSMutableArray alloc] init];
        //每条数据下面的总价
        CGFloat allprice = 0.0;
        
        for (WXShoppingCellModel *cellmodel in model.headCellArray) {
            
            //计算每个cell的总价
            if (cellmodel.cellClickState == 1) {
                
                [cellModelArray addObject:cellmodel];
                allprice = allprice + cellmodel.numInt * [cellmodel.price floatValue] ;
            }
            
           
            //纪录选中的必选单品
            if (cellmodel.cellClickState == 1 ){
                
                [array addObject:cellmodel.ID];
            }
            

        }
        
        if (array.count > 0) {
            [dict setObject:[NSString stringWithFormat:@"小计 ¥%.2f",allprice] forKey:@"footerTitle"];

        }

        
        model.headPriceDict = dict;
        }
        
    NSDictionary *dict = @{
                           @"cellModel":cellModelArray,
                           @"allPrice":[NSString stringWithFormat:@"￥%.2f",allPrict],
                           @"allState":allClickArray.count == _shoppingArray.count && _shoppingArray.count>0?@"YES":@"NO"
                           };
    NSNotification *notification =[NSNotification notificationWithName:@"AllPrice" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

//#pragma mark 返回 “搭配购” 下面必选单品的id，用于和当前选中的必选单品做比较
//-(NSArray *)RutrnCellModel:(WXShoppingModel *)model{
//    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (WXShoppingCellModel *cellmodel in model.headCellArray) {
//        
//        if (cellmodel.mustInteger == 1) {
//            
//            [array addObject:cellmodel.ID];
//        }
//    }
//    
//    return [array copy];
//}

#pragma mark 全选
-(void)allBtn:(BOOL)isbool{
    
    //当isbool为yes时,是全选状态，为no反之
    if (isbool) {
        
        for (WXShoppingModel *model in _shoppingArray) {
            
            //选中状态时 model.headClickState = 0; 然后调用 [self RefreshAllCellState:model];改为1
            model.headClickState = 0;
            [self RefreshAllCellState:model];
        }
        
    }else{
        
        for (WXShoppingModel *model in _shoppingArray) {
            
            model.headClickState = 1;
            [self RefreshAllCellState:model];
        }
    }
    
    [self CalculationPrice];
    [self.buyCartTabelView reloadData];
}

#pragma mark 编辑
-(void)editBtn:(BOOL)isbool{
    
    for (WXShoppingModel *model in _shoppingArray) {
        
        if (!isbool) {
            
            for (WXShoppingCellModel *cellmodel in model.headCellArray) {
                
                cellmodel.cellEditState = 1;
            }
            
        }else{
            
            for (WXShoppingCellModel *cellmodel in model.headCellArray) {
                
                cellmodel.cellEditState = 0;
            }
        }
    }
    
    [self.buyCartTabelView reloadData];
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
        cell.delegate = self;
    }
    


    
    self.editView = cell.editView;

    
    [cell.deleteButton addTarget:self action:@selector(ClickDeleteButton:) forControlEvents:UIControlEventTouchUpInside
     ];
    
    WXShoppingModel *shoppingmodel = _shoppingArray[indexPath.section];
    WXShoppingCellModel *cellmodel = shoppingmodel.headCellArray[indexPath.row];
    cellmodel.section = indexPath.section;
    cell.model = cellmodel;
  
    
    //点击cell时不变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
   
}



-(void)ClickDeleteButton:(UIButton *)sender{
    NSMutableArray *headDeleteArray = [[NSMutableArray alloc] init];
    for (WXShoppingModel *model in _shoppingArray) {
        
        if (model.headClickState == 1) {
            
            [headDeleteArray addObject:model];
            
        }else{
            
            NSMutableArray *cellDeleteArray = [[NSMutableArray alloc] init];
            for (WXShoppingCellModel *cellmodel in model.headCellArray) {
                
                if (cellmodel.cellClickState == 1) {
                    
                    [cellDeleteArray addObject:cellmodel];
                }
            }
            
            NSMutableArray *headcellArray = [NSMutableArray arrayWithArray:model.headCellArray];
            for (WXShoppingCellModel *cellmodel in cellDeleteArray) {
                
                if ([headcellArray containsObject:cellmodel]) {
                    
                    [headcellArray removeObject:cellmodel];
                }
            }
            model.headCellArray = headcellArray;
        }
        
    }
    
    NSMutableArray *shopArray = [NSMutableArray arrayWithArray:_shoppingArray];
    for (WXShoppingModel *model in headDeleteArray) {
        
        if ([shopArray containsObject:model]) {
            
            [shopArray removeObject:model];
        }
    }
    _shoppingArray = shopArray;
    
    [self CalculationPrice];
    [self.buyCartTabelView reloadData];
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
