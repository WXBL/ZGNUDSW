//
//  WXForgetPasswordViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXForgetPasswordViewController.h"
#import "WXTopView.h"
#import "WXUserService.h"
#import "validateTest.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import "WXTabBarController.h"
#import "validateTest.h"
#define FORGET_PASSWORD_URL @""
#define TELEVAIL_URL @""
@interface WXForgetPasswordViewController ()

@end

@implementation WXForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self addTitleView];
    [self addContent];
    [self addTestNet];
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"忘记密码"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
}
-(void)addTestNet{
    //    初始化提示框
    self.alertLbl=[[UILabel alloc] initWithFrame:CGRectMake((screenWidth-100)/2, 60, 100, 21)];
    self.alertLbl.text=@"当前网络不可用";
    self.alertLbl.textAlignment=NSTextAlignmentCenter;
    self.alertLbl.font=[UIFont fontWithName:nil size:14];
    self.alertLbl.textColor=[UIColor whiteColor];
    self.alertLbl.backgroundColor=[UIColor grayColor];
    self.alertLbl.alpha=0;
    [self.view addSubview:self.alertLbl];
    
    //    检测网络是否存在
    self.isHaveNet=[[NetWork alloc] init];
    if (![self.isHaveNet isHaveNetWork]) {
        self.registerBtn.enabled=NO;
        [self.registerBtn setBackgroundColor:[UIColor lightGrayColor]];
        [UIView animateWithDuration:1 animations:^{
            self.alertLbl.alpha=1;
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateKeyframesWithDuration:2 delay:1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                    self.alertLbl.alpha=0;
                }completion:^(BOOL finished){
                    if (finished) {
                        NSLog(@"it is not network");
                    }
                }];
            }
        }];
    }
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addContent{
    //手机号
    
    UIView *textView=[[UIView alloc] initWithFrame:CGRectMake(10, 100, screenWidth-20, 100)];
    textView.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:textView];
    
    self.telePhoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(textView.frame), 40)];
    self.telePhoneTextField.delegate=self;
    self.telePhoneTextField.backgroundColor=[UIColor whiteColor];
    self.telePhoneTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.telePhoneTextField.placeholder=@"请输入注册手机号";
    self.telePhoneTextField.keyboardType=UIKeyboardTypeNumberPad;
    [textView addSubview:self.telePhoneTextField];
    
    
    
    self.passTextField=[[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.telePhoneTextField.frame)+10, CGRectGetWidth(textView.frame), CGRectGetHeight(self.telePhoneTextField.frame))];
    self.passTextField.delegate=self;
    self.passTextField.placeholder=@"请输入新密码";
    self.passTextField.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    self.passTextField.borderStyle=UITextBorderStyleRoundedRect;
    [textView addSubview:self.passTextField];
    
    
    //    登录按钮
    UIView *loginBtnView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+50, screenWidth, 50)];
    loginBtnView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:loginBtnView];
    self.registerBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(loginBtnView.frame)/8, 0, CGRectGetWidth(loginBtnView.frame)/8*6, CGRectGetHeight(loginBtnView.frame))];
    [self.registerBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorWithWhite:1 alpha:2] forState:UIControlStateNormal];
    [self.registerBtn setBackgroundColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1]];
    self.registerBtn.layer.cornerRadius=10;
    self.registerBtn.layer.masksToBounds=YES;
    self.registerBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.registerBtn addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtnView addSubview:self.registerBtn];
    
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.telePhoneTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.telePhoneTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.telePhoneTextField resignFirstResponder];
    [self.passTextField resignFirstResponder];
}
-(void)registerButtonClick:(UIButton *)sender{
    
    //    [[WXUserService sharedClient] userRegistWithUserName:self.userName Password:self.password RegisterTime:@"" Telephone:self.telePhoneTextField.text Completion:^(NSString *success){
    //
    //    }Failure:^(NSString *error){
    //
    //    }];
    validateTest *test=[[validateTest alloc] init];
    UIAlertView * alertView=nil;
    if (![test validateMobile:self.telePhoneTextField.text]) {
        alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号格式不正确，请重新输入！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
         [alertView show];
        self.telePhoneTextField.text=@"";
    }else {
        if (self.passTextField.text.length<6||[self.passTextField.text isEqualToString:@""]) {
           alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不能小于6位,请重新输入" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [alertView show];
            self.passTextField.text=@"";
        }else{
            AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
            NSMutableDictionary *params=[NSMutableDictionary dictionary];
            params[@"Tel"]=self.self.telePhoneTextField.text;
            params[@"Password"]=self.passTextField.text;
            NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,FORGET_PASSWORD_URL];
            [mgr POST:path parameters:params success:^(AFHTTPRequestOperation *operation,NSString *responseObject){
                WXTabBarController *tabBar = [[WXTabBarController alloc]init];
                [self presentViewController:tabBar animated:YES completion:nil];
                
            }failure:^(AFHTTPRequestOperation *operation,NSError *error){
                UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"设置失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
                [alertView show];
            }];
        }
        
    }
    
    
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
