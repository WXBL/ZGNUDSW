//
//  WXVerifyTelephoneViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXVerifyTelephoneViewController.h"
#import "WXTopView.h"
#import "WXUserService.h"
#import "validateTest.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworking.h"
#import "WXTabBarController.h"
@interface WXVerifyTelephoneViewController ()

@end

@implementation WXVerifyTelephoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self addTitleView];
    [self addContent];
    [self addTestNet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"手机号验证"];
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
    UIView *userView=[[UIView alloc] initWithFrame:CGRectMake(1, 1, textView.frame.size.width-2, (textView.frame.size.height-3)/2)];
    userView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [textView addSubview:userView];
    
    
    self.telePhoneTextField=[[UITextField alloc] initWithFrame:CGRectMake(7, 5, CGRectGetWidth(userView.frame)-14, CGRectGetHeight(userView.frame)-10)];
    self.telePhoneTextField.delegate=self;
    self.telePhoneTextField.placeholder=@"请输入手机号";
    [userView addSubview:self.telePhoneTextField];
    
    UIView *passwordView=[[UIView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(userView.frame)+10, textView.frame.size.width/2+20, CGRectGetHeight(userView.frame))];
    passwordView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [textView addSubview:passwordView];
    
    
    
    self.verifyCodeTextField=[[UITextField alloc] initWithFrame:CGRectMake(7, 5, CGRectGetWidth(passwordView.frame), CGRectGetHeight(passwordView.frame)-10)];
    self.verifyCodeTextField.delegate=self;
    self.verifyCodeTextField.placeholder=@"请输入验证码";
    [passwordView addSubview:self.verifyCodeTextField];
    
    self.getVerifyCodeBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordView.frame)+5, CGRectGetMaxY(userView.frame)+10, screenWidth-CGRectGetMaxX(passwordView.frame)-30, CGRectGetHeight(passwordView.frame))];
    [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getVerifyCodeBtn setBackgroundColor:[UIColor  colorWithRed:0.2 green:0.7 blue:0.4 alpha:1]];
    [self.getVerifyCodeBtn addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:self.getVerifyCodeBtn];
    
    //    登录按钮
    UIView *loginBtnView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+50, screenWidth, 50)];
    loginBtnView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:loginBtnView];
    self.registerBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(loginBtnView.frame)/8, 0, CGRectGetWidth(loginBtnView.frame)/8*6, CGRectGetHeight(loginBtnView.frame))];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
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
    [self.verifyCodeTextField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.telePhoneTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.telePhoneTextField resignFirstResponder];
    [self.verifyCodeTextField resignFirstResponder];
}
-(void)registerButtonClick:(UIButton *)sender{
    
    //    [[WXUserService sharedClient] userRegistWithUserName:self.userName Password:self.password RegisterTime:@"" Telephone:self.telePhoneTextField.text Completion:^(NSString *success){
    //
    //    }Failure:^(NSString *error){
    //
    //    }];
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"UserName"]=self.userName;
    params[@"Password"]=self.password;
    params[@"Tel"]=self.telePhoneTextField.text;
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,@""];
    [mgr POST:path parameters:params success:^(AFHTTPRequestOperation *operation,NSString *responseObject){
        WXTabBarController *tabBar = [[WXTabBarController alloc]init];
        [self presentViewController:tabBar animated:YES completion:nil];
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
    }];
    
    
}
-(void)getVerifyCode:(UIButton *)sender{
    
    validateTest *test=[[validateTest alloc] init];
    if (![test validateMobile:self.telePhoneTextField.text]) {
        [self alertWithTitle:@"提示" msg:@"手机号格式不正确，请重新输入！"];
        self.telePhoneTextField.text=@"";
    }else{
        if ([MFMessageComposeViewController canSendText]) {
            MFMessageComposeViewController *controller=[[MFMessageComposeViewController alloc] init];
            controller.recipients=[NSArray arrayWithObject:self.telePhoneTextField.text];
            controller.body=@"asd";
            controller.messageComposeDelegate=self;
            [self presentModalViewController:controller animated:YES];
            [[[[controller viewControllers]lastObject]navigationItem]setTitle:@"test"];
        }else{
            [self alertWithTitle:@"提示" msg:@"该设备没有短信功能！"];
        }
    }
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissModalViewControllerAnimated:NO];
    switch (result) {
        case MessageComposeResultCancelled:
            [self alertWithTitle:@"提示" msg:@"发送取消！"];
            break;
        case MessageComposeResultFailed:
            [self alertWithTitle:@"提示" msg:@"发送失败！"];
            break;
        case MessageComposeResultSent:
            [self alertWithTitle:@"提示" msg:@"发送成功！"];
            break;
        default:
            break;
    }
}
-(void)alertWithTitle:(NSString *)title msg:(NSString *)msg{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
    [alert show];
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
