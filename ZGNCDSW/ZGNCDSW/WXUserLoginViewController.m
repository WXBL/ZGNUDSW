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
#import "WXUserRegistViewController.h"
#import "WXForgetPasswordViewController.h"
#import "WXUserService.h"
#import "MDDataBaseUtil.h"
@interface WXUserLoginViewController ()

@end

@implementation WXUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self addTitleView];
    [self addContent];
    [self addTestNet];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.userNameTextField.text=nil;
    self.passwordTextField.text=nil;
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"用户登录"];
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
        self.loginBtn.enabled=NO;
        [self.loginBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.forgetPasswordBtn.enabled=NO;
        [self.forgetPasswordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.registBtn.enabled=NO;
        [self.registBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
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
    [passwordView addSubview:self.passwordTextField];
    
    //    登录按钮
    UIView *loginBtnView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+20, screenWidth, 50)];
    loginBtnView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:loginBtnView];
    self.loginBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(loginBtnView.frame)/8, 0, CGRectGetWidth(loginBtnView.frame)/8*6, CGRectGetHeight(loginBtnView.frame))];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorWithWhite:1 alpha:2] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1]];
    self.loginBtn.layer.cornerRadius=10;
    self.loginBtn.layer.masksToBounds=YES;
    self.loginBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.loginBtn addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtnView addSubview:self.loginBtn];
    
    //    忘记密码按钮
    
    UIView *forgerPassView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(loginBtnView.frame)+20, screenWidth, 50)];
    forgerPassView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:forgerPassView];
    self.forgetPasswordBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(loginBtnView.frame)/3, 0, CGRectGetWidth(loginBtnView.frame)/3, CGRectGetHeight(loginBtnView.frame))];
    [self.forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPasswordBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.forgetPasswordBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.forgetPasswordBtn addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [forgerPassView addSubview:self.forgetPasswordBtn];
    
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(2, (CGRectGetHeight(forgerPassView.frame)-2)/2, CGRectGetWidth(forgerPassView.frame)/3-2, 2)];
    leftView.backgroundColor=[UIColor lightGrayColor];
    [forgerPassView addSubview:leftView];
    
    UIView *rightView=[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.forgetPasswordBtn.frame), (CGRectGetHeight(forgerPassView.frame)-2)/2, CGRectGetWidth(forgerPassView.frame)/3-2, 2)];
    rightView.backgroundColor=[UIColor lightGrayColor];
    [forgerPassView addSubview:rightView];
    
    
    //    注册按钮
    UIView *registBtnView=[[UIView alloc] initWithFrame:CGRectMake((screenWidth-200)/2, screenHeigth-100, 200, 50)];
    registBtnView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:registBtnView];
    
    self.registBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(registBtnView.frame), CGRectGetHeight(registBtnView.frame))];
    [self.registBtn setTitle:@"没有账号？去注册吧" forState:UIControlStateNormal];
    [self.registBtn setTitleColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1] forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [registBtnView addSubview:self.registBtn];
    
    
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
    UIAlertView *alertView=nil;
    if ([self.userNameTextField.text isEqualToString:@""]) {
        alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名，用户名不能为空！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
    }else {
        if([self.passwordTextField.text isEqualToString:@""]){
            alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入密码，密码不能为空！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [alertView show];
        }else if (self.passwordTextField.text.length<6){
            alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码必须大于6位，请重新输入！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [alertView show];
        }else{
            if(![self.isHaveNet isHaveNetWork]){
                [UIView animateWithDuration:1 animations:^{
                    self.alertLbl.alpha=1;
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateKeyframesWithDuration:2 delay:1 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
                            self.alertLbl.alpha=0;
                        }completion:^(BOOL finished){
                            if (finished) {
                                
                            }
                        }];
                    }
                }];
            }else{
                [[WXUserService sharedClient]userLoginWithUserName:self.userNameTextField.text Password:self.passwordTextField.text Completion:^(WXUserModel *model){
                    [MDDataBaseUtil setUserID:model.UserID];
                    [MDDataBaseUtil setPassword:model.Password];
                    [MDDataBaseUtil setUserName:model.UserName];
                    [MDDataBaseUtil setUserImage:model.User_image];
                    [MDDataBaseUtil setTel:model.Tel];
                    [MDDataBaseUtil setSex:model.Sex];
                    [MDDataBaseUtil setNowAddress:model.Now_address];
                    [MDDataBaseUtil setLevelID:model.Level_ID];
                    [MDDataBaseUtil setLastLoginTime:model.Last_login_time];
                    [MDDataBaseUtil setLoginAddress:model.Login_address];
                    [MDDataBaseUtil setAge:model.Age];
                    [MDDataBaseUtil setRegistTime:model.Regist_time];
                    [MDDataBaseUtil setEmail:model.Email];
                    [MDDataBaseUtil setLevelID:model.Level_ID];
                    [MDDataBaseUtil setRankContent:model.Rank_Content];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }Failure:^(NSString *error){
                    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
                    [alertView show];
                }];
            }
        }
        
    }
    
}

//点击注册按钮触发事件
-(void)registerButtonClick:(UIButton *)sender{
    WXUserRegistViewController *registVC=[[WXUserRegistViewController alloc] init];
    [self presentViewController:registVC animated:YES completion:nil];
}

-(void)forgetPassword:(UIButton *)sender{
    WXForgetPasswordViewController *forgetVC=[[WXForgetPasswordViewController alloc] init];
    [self presentViewController:forgetVC animated:YES completion:nil];
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
