//
//  WXAddAddressViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddAddressViewController.h"
#import "WXTopView.h"
#import "AddressChoicePickerView.h"
#import "AreaObject.h"
#import "validateTest.h"
#import "WXAddressModel.h"
@interface WXAddAddressViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UITableView *tableView;



//@property (nonatomic,strong)WXAddressModel *addressModel;

@end

@implementation WXAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self addNavBar];
    
    [self addTableView];
    
    [self addSaveBtn];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.nameText.text = nil;
    self.phoneText.text = nil;
    self.PostcodesText.text = nil;
    self.addressDetail.text = nil;
    
}

-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"收货地址"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView = topView;
}

-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.topView.frame.size.height, screenWidth, screenHeigth/2-self.topView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
}

-(void)addSaveBtn{
    UIButton *saveBtn = [[UIButton alloc]init];
    saveBtn.frame = CGRectMake(screenWidth *0.1, self.tableView.frame.size.height, screenWidth *0.8, 40);
    [saveBtn setTitle:@"保存地址" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithRed:0.7 green:0.2 blue:0.2 alpha:1]];
    [saveBtn addTarget:self action:@selector(ClickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

-(void)ClickSaveBtn:(UIButton *)button{
    
    if ([self.delegate respondsToSelector:@selector(addressViewController:didClickButton:)]) {
        [self.delegate addressViewController:self didClickButton:button];
    }
   
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.row ==0) {
            self.nameText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, screenWidth-10, 40)];
            self.nameText.placeholder = @"收货人姓名";
            self.nameText.font = [UIFont systemFontOfSize:14];
            //    self.nameText.keyboardType = UIKeyboardType;
            self.nameText.delegate = self;
            [cell addSubview:self.nameText];
        }else if (indexPath.row == 1){
            self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, screenWidth - 10, 40)];
            self.phoneText.placeholder = @"手机号码";
            self.phoneText.font = [UIFont systemFontOfSize:14];
            self.phoneText.delegate = self;

            [cell addSubview:self.phoneText];
        }else if (indexPath.row == 2){
           
            self.areaText = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth - 10, 40)];
            self.areaText.text = @"省、市、区";
            self.areaText.textColor = [UIColor blackColor];
            self.areaText.font = [UIFont systemFontOfSize:14];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addSubview:self.areaText];
        
            
        }else if (indexPath.row ==3){
            self.PostcodesText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, screenWidth-10, 40)];
            self.PostcodesText.placeholder = @"邮编";
            self.PostcodesText.font = [UIFont systemFontOfSize:14];
            self.PostcodesText.delegate =self;
            
            [cell addSubview:self.PostcodesText];
        }
        else{
            self.addressDetail = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, screenWidth - 10, 50)];
            self.addressDetail.placeholder = @"详细地址";
            self.addressDetail.font = [UIFont systemFontOfSize:14];
            self.addressDetail.delegate = self;
            [cell.contentView addSubview:self.addressDetail];
            
            
        }

    }
    
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    
    [self.nameText resignFirstResponder];
    [self.phoneText resignFirstResponder];
    [self.PostcodesText resignFirstResponder];
    [self.addressDetail resignFirstResponder];
    
    return YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        AddressChoicePickerView *addressPickerView = [[AddressChoicePickerView alloc]init];
        addressPickerView.block = ^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
            self.areaText.text = [NSString stringWithFormat:@"%@",locate];
            self.areaText.textColor = [UIColor blackColor];
            
        };
        
        [addressPickerView show];
        
        [self.view addSubview:addressPickerView];
        
        [self.nameText resignFirstResponder];
        [self.phoneText resignFirstResponder];
        [self.PostcodesText resignFirstResponder];
        [self.addressDetail resignFirstResponder];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==4) {
        return 60;
    }
    return 40;
}


-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
