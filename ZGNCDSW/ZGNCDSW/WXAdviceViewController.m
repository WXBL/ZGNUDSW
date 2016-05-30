//
//  WXAdviceViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAdviceViewController.h"
#import "WXTopView.h"
#import "WXOptionPickerView.h"

@interface WXAdviceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,WXOptionPickerViewDelegate>

@property (nonatomic,strong)WXTopView *topView;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UITextView *questDetailTextView;
@property (nonatomic,strong)UILabel *placeholderLabel;

@property (nonatomic,strong)UITextField *inputTextFiled;

//输入错误提示
@property (nonatomic,strong)UILabel *inputErrorPoint1;
@property (nonatomic,strong)UILabel *inputErrorPoint2;

@property (nonatomic,strong)UILabel *selectCategoryLabel;

@property (nonatomic,assign)NSInteger selectedIndex;

@property (nonatomic,strong)NSArray *categories;
@property (nonatomic,strong)NSArray *categoryiesName;

@property (nonatomic,strong)WXOptionPickerView *picker;

@end

@implementation WXAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavBar];
    
    [self addTableView];
    
    self.categoryiesName = [NSArray arrayWithObjects:@"无",@"登录／注册不了",@"联网太忙",@"忘记密码／帐号", nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.selectCategoryLabel  = [[UILabel alloc]init];
    self.selectCategoryLabel .text = @"无";
    self.selectCategoryLabel .font = [UIFont systemFontOfSize:14];
    self.selectCategoryLabel .textColor = [UIColor blackColor];
    self.selectCategoryLabel .textAlignment = NSTextAlignmentLeft;
//    [self.tableView reloadData];
}

-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"意见反馈"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView =topView;
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(screenWidth-60, 10, 40, 40);
    [registerBtn setTitle:@"提交" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [registerBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:registerBtn];
    
    
}

-(void)submit:(UIButton *)sender{
    [self.inputTextFiled resignFirstResponder];
    [self.questDetailTextView resignFirstResponder];
    
    NSString *inputDescription = [self.questDetailTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (inputDescription && inputDescription.length <200 && inputDescription.length >10) {
        [self.inputErrorPoint1 setHidden:YES];
        
        NSString *phone = [self.inputTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (!phone || ![self isContact:phone]) {
            [self.inputErrorPoint2 setHidden:NO];
        }else{
            [self sendSubmitRequest];
            [self showFloatMessageZP:@"正在提交"];
        }
    }else{
        [self.inputErrorPoint1 setHidden:NO];
    }
}

-(void)sendSubmitRequest{
    
}

-(void)showFloatMessageZP:(NSString*)message
{
    
}
#pragma mark - Pivatemethod
- (BOOL)isContact:(NSString *)text
{
    NSString *emailRegex = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    NSString * mobileOrQQ = @"[1-9][0-9]{4,14}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileOrQQ];
    if ([regextestmobile evaluateWithObject:text] == NO && [emailTest evaluateWithObject:text] == NO) {
        return NO;
    }
    return YES;
}


-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), screenWidth, screenHeigth - self.topView.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
    
}

#pragma mark tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

/**
 * section底部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}

/**
 * section顶部间距
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"AdviceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
//                self.questionCategoryCell = [[UITableViewCell alloc]init];
//                [self.questionCategoryCell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                UILabel *questionCategoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth * 0.25, 50)];
                questionCategoryLabel.text = @"问题类型";
                questionCategoryLabel.textColor = [UIColor grayColor];
                questionCategoryLabel.font = [UIFont systemFontOfSize:16];
                questionCategoryLabel.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:questionCategoryLabel];
                
//                UILabel *selectCategoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(questionCategoryLabel.frame), 0, screenWidth *0.6, 50)];
//                selectCategoryLabel.text = @"无";
//                selectCategoryLabel.font = [UIFont systemFontOfSize:14];
//                selectCategoryLabel.textColor = [UIColor blackColor];
//                selectCategoryLabel.textAlignment = NSTextAlignmentLeft;
//                [cell addSubview:selectCategoryLabel];
                self.selectCategoryLabel.frame=CGRectMake(CGRectGetMaxX(questionCategoryLabel.frame), 0, screenWidth *0.6, 50);
                [cell addSubview:self.selectCategoryLabel];
                
                UIImageView *downImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.selectCategoryLabel.frame)+10, 20, 15, 15)];
                [downImage setImage:[UIImage imageNamed:@"向下箭头icon"]];
                [cell addSubview:downImage];
            }
        }
            break;
        case 1:
        {
            if (indexPath.row ==0) {
                self.questDetailTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 5, screenWidth-20, 90)];
                self.questDetailTextView.delegate = self;
                //修复文本框是否偏移
                self.automaticallyAdjustsScrollViewInsets = NO;
                
                self.questDetailTextView.textAlignment = NSTextAlignmentLeft;
                self.questDetailTextView.textColor = [UIColor blackColor];
                self.questDetailTextView.font = [UIFont systemFontOfSize:14];
                //设置编辑使能属性，是否允许编辑（＝NO时只用来显示，依然可以使用选择和拷贝功能）
                self.questDetailTextView.editable = YES;
                self.questDetailTextView.backgroundColor = [UIColor whiteColor];
                
                [cell addSubview:self.questDetailTextView];
                
                self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.questDetailTextView.frame), 20)];
                self.placeholderLabel.text = @"请输入详细需要反馈的内容";
                self.placeholderLabel.textColor = [UIColor grayColor];
                self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
                self.placeholderLabel.font = [UIFont systemFontOfSize:12];
                [self.questDetailTextView addSubview:self.placeholderLabel];
            }
        }
            break;
        case 2:
        {
            if (indexPath.row ==0) {
                UILabel *contactLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth * 0.25, 50)];
                contactLabel.text = @"联系方式";
                contactLabel.textColor = [UIColor grayColor];
                contactLabel.font = [UIFont systemFontOfSize:16];
                contactLabel.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:contactLabel];

                self.inputTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(contactLabel.frame), 0, screenWidth * 0.7, contactLabel.frame.size.height)];
                self.inputTextFiled.delegate = self;
                self.inputTextFiled.placeholder = @"请输入手机号／邮箱／qq";
                self.inputTextFiled.textAlignment = NSTextAlignmentLeft;
                self.inputTextFiled.font = [UIFont systemFontOfSize:14];
                self.inputTextFiled.textColor = [UIColor blackColor];
                [cell addSubview:self.inputTextFiled];
            }
        }
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


/**
 * section底部添加错误提示信息
 */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        UIView *footerView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
        footerView1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        self.inputErrorPoint1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth, footerView1.frame.size.height)];
        self.inputErrorPoint1.text = @"请输入10-200个字符";
        self.inputErrorPoint1.textColor = [UIColor redColor];
        self.inputErrorPoint1.textAlignment = NSTextAlignmentLeft;
        self.inputErrorPoint1.font = [UIFont systemFontOfSize:12];
        self.inputErrorPoint1.hidden = YES;
        [footerView1 addSubview:self.inputErrorPoint1];
        
        return footerView1;
    }else if (section ==2){
        UIView *footerView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 20)];
        footerView2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        self.inputErrorPoint2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, screenWidth, footerView2.frame.size.height)];
        self.inputErrorPoint2.text = @"请输入正确的联系方式格式";
        self.inputErrorPoint2.textColor = [UIColor redColor];
        self.inputErrorPoint2.textAlignment = NSTextAlignmentLeft;
        self.inputErrorPoint2.font = [UIFont systemFontOfSize:12];
        self.inputErrorPoint2.hidden = YES;
        [footerView2 addSubview:self.inputErrorPoint2];
        return footerView2;
    }
    return nil;
   
}


#pragma mark - UITextFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.inputTextFiled resignFirstResponder];
    
    return YES;
}

#pragma mark - UITextViewdDelegate  开始编辑
-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑");
    self.placeholderLabel.text = @"";
}

//结束编辑
-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"结束编辑");
    
    //模仿UITextFiled的placeholder属性
    if (self.questDetailTextView.text.length == 0) {
        self.placeholderLabel.text = @"请输入详细需要反馈的内容";
    }else{
        self.placeholderLabel.text = @"";
    }
}



/**
 * 监听点击事件，当点击非textfiled位置的时候，所有输入法全部收缩
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.questDetailTextView resignFirstResponder];
    [self.inputTextFiled resignFirstResponder];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self chooseQuestionCategory];
    }
    
}

-(void)chooseQuestionCategory{
    [self.questDetailTextView resignFirstResponder];
    [self.inputTextFiled resignFirstResponder];
    
//    if (self.categories) {
        if (!self.picker) {
            self.picker = [[WXOptionPickerView alloc]initWithOptions:self.categoryiesName frame:[[UIApplication sharedApplication]keyWindow].bounds];
            self.picker.delegate = self;
            [self.picker setTitle:@"反馈类型"];
        }
        [self.picker show];
//    }else{
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"问题类型正在获取中，请稍后重试" preferredStyle:UIAlertControllerStyleAlert];
//        
//        
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//        
//            [alertController addAction:okAction];
//
//        
//        [self presentViewController:alertController animated:YES completion:nil];
//        
//        //获取数据
//        [self getQuestionCategories];
//    }
}

-(void)getQuestionCategories{
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 50;
    }else if (indexPath.section ==1){
        return 100;
    }else{
        return 50;
    }
    
}

#pragma mark - QuestionCategoryPickerDelegate
-(void)optionPickerView:(WXOptionPickerView *)pickerView didSelectOptionAtIndex:(NSNumber *)index{
    [self.picker dismiss];
    self.selectedIndex = index.integerValue;
    
    self.selectCategoryLabel.text = [self.categoryiesName objectAtIndex:self.selectedIndex];
    
//    [self.tableView reloadData];
}

-(void)optionPickerViewDidCancel:(WXOptionPickerView *)pickerView{
    [self.picker dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
