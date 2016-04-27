//
//  WXUserLoginViewController.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXUserLoginViewController.h"
#import "WXTopView.h"
#import "MBProgressHUD.h"
#import "WXTabBarController.h"

@interface WXUserLoginViewController ()

@end

@implementation WXUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self addTitleView];
    [self addContent];
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"用户登录"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
}
-(void)addContent{
//    用户名密码输入框
    UIView *textView=[[UIView alloc] initWithFrame:CGRectMake(10, 100, screenWidth-20, 100)];
    textView.backgroundColor=[UIColor colorWithWhite:0.7 alpha:1];
    [self.view addSubview:textView];
    UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(1, 1, textView.frame.size.width-2, (textView.frame.size.height-3)/2)];
    userView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [textView addSubview:userView];
    
    UIImageView *userImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, (CGRectGetHeight(userView.frame)-30)/2, 30, 30)];
    userImgView.image=[UIImage imageNamed:@"reg_username_txt.png"];
    [userView addSubview:userImgView];
    
    
    self.userNameTextField=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImgView.frame)+2, 5, CGRectGetWidth(userView.frame)-CGRectGetMaxX(userImgView.frame)-2, CGRectGetHeight(userView.frame)-10)];
    self.userNameTextField.delegate=self;
    self.userNameTextField.placeholder=@"请输入用户名";
    [userView addSubview:self.userNameTextField];
    
    UIView *passwordView=[[UIView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(userView.frame)+1, textView.frame.size.width-2, CGRectGetHeight(userView.frame))];
    passwordView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [textView addSubview:passwordView];
    
    UIImageView *passwordImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, (CGRectGetHeight(userView.frame)-30)/2, 30, 30)];
    passwordImgView.image=[UIImage imageNamed:@"reg_pwd_txt.png"];
    [passwordView addSubview:passwordImgView];
    
    
    self.passwordTextField=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImgView.frame)+2, 5, CGRectGetWidth(passwordView.frame)-CGRectGetMaxX(passwordImgView.frame)-2, CGRectGetHeight(passwordView.frame)-10)];
    self.passwordTextField.delegate=self;
    self.passwordTextField.placeholder=@"请输入密码";
    [userView addSubview:self.passwordTextField];
    
//    登录按钮
    UIView *loginBtnView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+20, screenWidth, 50)];
    loginBtnView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:loginBtnView];
    UIButton *loginBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(loginBtnView.frame)/8, 0, CGRectGetWidth(loginBtnView.frame)/8*6, CGRectGetHeight(loginBtnView.frame))];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithWhite:1 alpha:2] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1]];
    loginBtn.layer.cornerRadius=10;
    loginBtn.layer.masksToBounds=YES;
    loginBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [loginBtn addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtnView addSubview:loginBtn];
    
//    忘记密码按钮
    
    UIView *forgerPassView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+20, screenWidth, 50)];
    forgerPassView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:forgerPassView];
    UIButton *forgetPasswordBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(loginBtnView.frame)/8, 0, CGRectGetWidth(loginBtnView.frame)/8*6, CGRectGetHeight(loginBtnView.frame))];
    [forgetPasswordBtn setTitle:@"登录" forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:[UIColor colorWithWhite:1 alpha:2] forState:UIControlStateNormal];
    [forgetPasswordBtn setBackgroundColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1]];
    forgetPasswordBtn.layer.cornerRadius=10;
    forgetPasswordBtn.layer.masksToBounds=YES;
    forgetPasswordBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [forgetPasswordBtn addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [forgerPassView addSubview:forgetPasswordBtn];
    
//    注册按钮
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
//点击登录按钮触发事件
-(void)loginButtonClick:(UIButton *)sender{
}

//点击注册按钮触发事件
-(void)registerButtonClick:(UIButton *)sender{
//    WXRegisterViewController *registerViewController = [[WXRegisterViewController alloc]init];
//    
//    [self presentViewController:registerViewController animated:YES completion:nil];
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
