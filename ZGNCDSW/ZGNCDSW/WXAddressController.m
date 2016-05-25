//
//  WXAddressController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddressController.h"
#import "WXTopView.h"

#import "WXAddressTableViewCell.h"
#import "WXAddressModel.h"
#import "WXAddressFrame.h"
#import "validateTest.h"
@interface WXAddressController ()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL isbool;
    
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)NSMutableArray *addressArray;


@property (nonatomic,assign)NSInteger theTag;
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
   
    self.addressArray = [NSMutableArray array];
//    WXAddressModel *addressModel=[[WXAddressModel alloc] init];
//    addressModel.username=@"asd";
//    addressModel.Phone=@"15075056282";
//    addressModel.Specific_Address = @"tinajinshiaseflkjwhelkhsfkhaskldfjhlkasjhdflkjaslkdlksfjhlkasjhdflkasjhdflkajhsdflkjhaslkdjfhlkasjhdflkajhsdfkljhaskdfjhalksjdhflkasjhdfkajshdkfjhwuqingqu";
//    addressModel.username=@"asd";
//    addressModel.Phone=@"15075056282";
//    addressModel.Specific_Address = @"tinajinshiaseflkjwhelkhsfkhaskldfjhlkasjhdflkjaslkdlksfjhlkasjhdflkasjhdflkajhsdflkjhaslkdjfhlkasjhdflkajhsdfkljhaskdfjhalksjdhflkasjhdfkajshdkfjhwuqingqu";
//    [self.addressArray addObject:addressModel];
//    [self.addressArray addObject:addressModel];
    
   
    
    [self addNavBar];
    
    [self addTableView];
    
    [self addAddressButton];
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    WXAddAddressViewController *addAddressController = [[WXAddAddressViewController alloc]init];
    
    addAddressController.delegate = self;
    [self.tableView reloadData];
}

-(void)addressViewController:(UIViewController *)addressViewController didClickButton:(UIButton *)button{
    
    WXAddAddressViewController *addAddressController = [[WXAddAddressViewController alloc]init];
    
    if (([addAddressController.nameText.text isEqualToString:@""]|| [addAddressController.phoneText.text isEqualToString:@""]||[addAddressController.PostcodesText.text isEqualToString:@""]||[addAddressController.addressDetail.text isEqualToString:@""])&& [addAddressController.areaText.text isEqualToString:@"省、市、区"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请完善收货地址信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *established = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:established];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        validateTest *test=[[validateTest alloc] init];
        if (![test validateMobile:addAddressController.phoneText.text]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号格式不正确请重新填写！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *established = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:cancelAction];
            [alertController addAction:established];
            addAddressController.phoneText=nil;
        }else{
            WXAddressModel *addressModel = [[WXAddressModel alloc]init];
            addressModel.username = addAddressController.nameText.text;
            addressModel.Phone = addAddressController.phoneText.text;
            addressModel.Specific_Address = addAddressController.addressDetail.text;
            addressModel.addName = addAddressController.areaText.text;
            
            [self.addressArray addObject:addressModel];
            
            [self.tableView reloadData];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
        
    }

}


-(void)setData{
    
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
//    return 3;
    return self.addressArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    WXAddressTableViewCell *cell = [WXAddressTableViewCell cellWithTableView:tableView];
    cell.toolbar.defaultBtn.tag = indexPath.row;
    WXAddressFrame *frame=[[WXAddressFrame alloc] init];
    WXAddressModel *model=[self.addressArray objectAtIndex:indexPath.row];
    frame.address=model;
    cell.addressFrame =frame;
    
    [cell.toolbar.defaultBtn addTarget:self action:@selector(ClickDefaultBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
    return cell;
    

}

-(void)ClickDefaultBtn:(UIButton *)button{

        for (UIView *view in self.tableView.visibleCells) {
            for (UIView *theView in view.subviews) {
                for (UIView *littleView in theView.subviews) {
                    if ([littleView isKindOfClass:[UIButton class]]) {
                        UIButton *btn=(UIButton *)littleView;
                        if (btn==button) {
                            [btn setSelected:YES];
                        }else{
                            [btn setSelected:NO];
                        }
                        NSLog(@"%ld",btn.tag);
                    }
                }
            }
        }
    
       [self.tableView reloadData];
}

#pragma mark tableView -delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WXAddressFrame *frame=[[WXAddressFrame alloc] init];
    WXAddressModel *model=[self.addressArray objectAtIndex:indexPath.row];
    frame.address=model;
    
    return frame.cellHeight;
 
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
