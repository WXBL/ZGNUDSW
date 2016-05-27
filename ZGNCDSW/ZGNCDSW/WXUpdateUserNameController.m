//
//  WXUpdateUserNameController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXUpdateUserNameController.h"
#import "WXTopView.h"
@interface WXUpdateUserNameController ()<UITextFieldDelegate>

@property (nonatomic,strong)UITextField *nameText;
@end

@implementation WXUpdateUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self addNavBar];
    
    [self updateTextFiled];
}

-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"修改昵称"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    UIButton *updateFinish = [UIButton buttonWithType:UIButtonTypeCustom];
    updateFinish.frame = CGRectMake(topView.frame.size.width - 80, 10, 80, topView.frame.size.height);
    [updateFinish setTitle:@"确定" forState:UIControlStateNormal];
    [updateFinish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [updateFinish addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    updateFinish.titleLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:updateFinish];
    
}

-(void)updateTextFiled
{
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, 40)];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    self.nameText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, screenWidth-10, 40)];
    self.nameText.backgroundColor = [UIColor whiteColor];
    self.nameText.keyboardType = UIKeyboardTypeDefault;//键盘显示类型
    self.nameText.placeholder = @"请输入昵称";
    self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    self.nameText.font = [UIFont systemFontOfSize:14];
    self.nameText.delegate = self;
    
    [nameView addSubview:self.nameText];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.nameText resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.nameText.text=textField.text;
    [self.nameText resignFirstResponder];
    
}

-(void)finishClick{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认修改吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
    
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeUserNameNotification" object:self userInfo:@{@"name":self.nameText.text}];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
