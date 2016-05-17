//
//  WXResetPasswordViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXResetPasswordViewController.h"
#import "WXTopView.h"
#import "MDDataBaseUtil.h"
#import "WXUserService.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "WXUserLoginViewController.h"
#define  RESET_PASSWORD_URL @""
@interface WXResetPasswordViewController ()

@end

@implementation WXResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1];
    [self addTitleView];
    [self addContent];
    [self addTestNet];
}
-(void)viewWillAppear:(BOOL)animated{
    self.originPasswordText.text=nil;
    self.resetPasswordText.text=nil;
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"重置密码"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
}
-(void)addTestNet{
    //    初始化提示框
    self.alertLbl=[[UILabel alloc] initWithFrame:CGRectMake((screenWidth-100)/2, 60, 100, 21)];
    self.alertLbl.text=@"当前网络不可用";
    self.alertLbl.textAlignment=NSTextAlignmentCenter;
    self.alertLbl.font=[UIFont systemFontOfSize:14];
    self.alertLbl.textColor=[UIColor whiteColor];
    self.alertLbl.backgroundColor=[UIColor grayColor];
    self.alertLbl.alpha=0;
    [self.view addSubview:self.alertLbl];
    
    //    检测网络是否存在
    self.isHaveNet=[[NetWork alloc] init];
    if (![self.isHaveNet isHaveNetWork]) {
        self.resetPasswordBtn.enabled=NO;
        [self.resetPasswordBtn setBackgroundColor:[UIColor lightGrayColor]];
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
    userImgView.image=[UIImage imageNamed:@"reg_pwd_txt.png"];
    [userView addSubview:userImgView];
    
    
    self.originPasswordText=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImgView.frame)+2, 5, CGRectGetWidth(userView.frame)-CGRectGetMaxX(userImgView.frame)-2, CGRectGetHeight(userView.frame)-10)];
    self.originPasswordText.delegate=self;
    self.originPasswordText.placeholder=@"请输入原始密码";
    [userView addSubview:self.originPasswordText];
    
    UIView *passwordView=[[UIView alloc] initWithFrame:CGRectMake(1, CGRectGetMaxY(userView.frame)+1, textView.frame.size.width-2, CGRectGetHeight(userView.frame))];
    passwordView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
    [textView addSubview:passwordView];
    
    UIImageView *passwordImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, (CGRectGetHeight(userView.frame)-30)/2, 30, 30)];
    passwordImgView.image=[UIImage imageNamed:@"reg_pwd_txt.png"];
    [passwordView addSubview:passwordImgView];
    
    
    self.resetPasswordText=[[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(passwordImgView.frame)+2, 5, CGRectGetWidth(passwordView.frame)-CGRectGetMaxX(passwordImgView.frame)-2, CGRectGetHeight(passwordView.frame)-10)];
    self.resetPasswordText.delegate=self;
    self.resetPasswordText.placeholder=@"请输入新密码";
    [passwordView addSubview:self.resetPasswordText];
    
    //    登录按钮
    UIView *resetBtnView=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+20, screenWidth, 50)];
    resetBtnView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:resetBtnView];
    self.resetPasswordBtn=[[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(resetBtnView.frame)/8, 0, CGRectGetWidth(resetBtnView.frame)/8*6, CGRectGetHeight(resetBtnView.frame))];
    [self.resetPasswordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [self.resetPasswordBtn setTitleColor:[UIColor colorWithWhite:1 alpha:2] forState:UIControlStateNormal];
    [self.resetPasswordBtn setBackgroundColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1]];
    self.resetPasswordBtn.layer.cornerRadius=10;
    self.resetPasswordBtn.layer.masksToBounds=YES;
    self.resetPasswordBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.resetPasswordBtn addTarget:self action:@selector(resetPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [resetBtnView addSubview:self.resetPasswordBtn];
    
    
    
    
}
//点击登录按钮触发事件
-(void)resetPasswordButtonClick:(UIButton *)sender{
    //    [[WXUserService sharedClient] updateUserPasswordWithUserID:[MDDataBaseUtil userID] UserName:[MDDataBaseUtil userName] ReSetPassword:self.resetPasswordText.text Completion:^(NSString* success){
    //        [MDDataBaseUtil setPassword:self.resetPasswordText.text];
    //    }Failure:^(NSString *error){
    //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"修改密码失败！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
    //        [alert show];
    //    }];
    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    params[@"ReSetPassword"]=self.resetPasswordText.text;
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,RESET_PASSWORD_URL];
    [mgr POST:path parameters:params success:^(AFHTTPRequestOperation *operation,NSDictionary *responseObject){
        [MDDataBaseUtil setPassword:self.resetPasswordText.text];
        WXUserLoginViewController *userLoginVC=[[WXUserLoginViewController alloc] init];
        [self presentViewController:userLoginVC animated:YES completion:nil];
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.originPasswordText resignFirstResponder];
    [self.resetPasswordText resignFirstResponder];
    [self isTrueOfOriginPassword];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.originPasswordText resignFirstResponder];
    [self.resetPasswordText resignFirstResponder];
    [self isTrueOfOriginPassword];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.originPasswordText resignFirstResponder];
    [self.resetPasswordText resignFirstResponder];
    [self isTrueOfOriginPassword];
}
-(void)isTrueOfOriginPassword{
    UIAlertView *alertView=nil;
    NSString *originPassword=(NSString *)[MDDataBaseUtil password];
    if (![self.originPasswordText.text isEqualToString:originPassword]) {
        alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新输入原始密码！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
        self.originPasswordText.text=nil;
    }else{
        if ([self.resetPasswordText.text isEqualToString:@""]) {
            alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码不能为空！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [alertView show];
        }else if(self.resetPasswordText.text.length<6){
            alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码必须大于6位！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
            [alertView show];
            self.originPasswordText.text=nil;
        }else{
            if(![self.isHaveNet isHaveNetWork]){
                self.resetPasswordBtn.enabled=NO;
                [self.resetPasswordBtn setBackgroundColor:[UIColor lightGrayColor] ];
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
                self.resetPasswordBtn.enabled=YES;
                [self.resetPasswordBtn setBackgroundColor:[UIColor colorWithRed:0.2 green:0.7 blue:0.4 alpha:1]];
            }
            
        }
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
