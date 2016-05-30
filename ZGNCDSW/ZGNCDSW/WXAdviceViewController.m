//
//  WXAdviceViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAdviceViewController.h"
#import "WXTopView.h"
@interface WXAdviceViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)WXTopView *topView;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UITextView *questDetailTextView;
@property (nonatomic,strong)UILabel *placeholderLabel;


@property (nonatomic,strong)UITableViewCell *questionCategoryCell;
@property (nonatomic,strong)UITableViewCell *questionContentCell;
@property (nonatomic,strong)UITableViewCell *phoneCell;

@property (nonatomic,strong)UILabel *selectCategoryLabel;
@end

@implementation WXAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavBar];
    
    [self addTableView];
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
    
}

-(void)addTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), screenWidth, screenHeigth - self.topView.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
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
                
                UILabel *selectCategoryLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(questionCategoryLabel.frame), 0, screenWidth *0.6, 50)];
                selectCategoryLabel.text = @"无";
                selectCategoryLabel.font = [UIFont systemFontOfSize:14];
                selectCategoryLabel.textColor = [UIColor blackColor];
                selectCategoryLabel.textAlignment = NSTextAlignmentLeft;
                [cell addSubview:selectCategoryLabel];
                self.selectCategoryLabel = selectCategoryLabel;
                
                UIImageView *downImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(selectCategoryLabel.frame)+10, 20, 15, 15)];
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
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self chooseQuestionCategory];
    }
    
}

-(void)chooseQuestionCategory{
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
