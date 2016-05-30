//
//  WXSetPassViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXSetPassViewController.h"
#import "WXTopView.h"
#import "MDDataBaseUtil.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#define  RESET_PASSWORD_URL @""
@interface WXSetPassViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)WXTopView *topView;

@property (nonatomic,strong)UITextField *oldPassText;
@property (nonatomic,strong)UITextField *passText;
@end

@implementation WXSetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self addNavBar];
    
    [self setPassView];
}


-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"账户安全"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView =topView;
}

-(void)setPassView{
    UIView *oldPassView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10, screenWidth, 40)];
    oldPassView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oldPassView];
    
    UIView *newPassView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oldPassView.frame)+10, screenWidth, 40)];
    newPassView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:newPassView];
    
    UILabel *oldPassLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, screenWidth*0.2-20, oldPassView.frame.size.height)];
    oldPassLabel.text = @"原密码";
    oldPassLabel.textColor = [UIColor blackColor];
    oldPassLabel.textAlignment = NSTextAlignmentLeft;
    oldPassLabel.font = [UIFont systemFontOfSize:14];
    [oldPassView addSubview:oldPassLabel];
    
    self.oldPassText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oldPassLabel.frame)+10, 0, screenWidth-(CGRectGetMaxX(oldPassLabel.frame)+10), oldPassView.frame.size.height)];
    self.oldPassText.placeholder = @"原密码";
    self.oldPassText.textColor = [UIColor blackColor];
    self.oldPassText.font = [UIFont systemFontOfSize:13];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    self.oldPassText.clearButtonMode = UITextFieldViewModeAlways;
    self.oldPassText.secureTextEntry = YES;//输入的字符是一个点（用于输入密码格式）
    [oldPassView addSubview:self.oldPassText];
    
    UILabel *newPassLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, screenWidth*0.2-20, newPassView.frame.size.height)];
    newPassLabel.text = @"新密码";
    newPassLabel.textColor = [UIColor blackColor];
    newPassLabel.textAlignment = NSTextAlignmentLeft;
    newPassLabel.font = [UIFont systemFontOfSize:14];
    [newPassView addSubview:newPassLabel];
    
    self.passText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newPassLabel.frame)+10, 0, screenWidth-(CGRectGetMaxX(newPassLabel.frame)+10), newPassView.frame.size.height)];
    self.passText.placeholder = @"新密码";
    self.passText.textColor = [UIColor blackColor];
    self.passText.font = [UIFont systemFontOfSize:13];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    self.passText.clearButtonMode = UITextFieldViewModeAlways;
    self.passText.secureTextEntry = YES;//输入的字符是一个点（用于输入密码格式）
    [newPassView addSubview:self.passText];
   
    //输入字符约束标签
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(newPassLabel.frame.origin.x, CGRectGetMaxY(newPassView.frame), screenWidth, 40)];
    label.text = @"请输入4-6个字符";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
    UIButton *updatePassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updatePassBtn.frame = CGRectMake(screenWidth *0.1, CGRectGetMaxY(label.frame), screenWidth *0.8, 40);
    [updatePassBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [updatePassBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updatePassBtn.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    updatePassBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [updatePassBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [updatePassBtn addTarget:self action:@selector(ClickSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:updatePassBtn];

}

-(void)ClickSaveBtn:(UIButton *)sender{
    if ([self.oldPassText.text isEqualToString:@""] || [self.passText.text isEqualToString:@""]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
        
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:nil];
        
//        [alertController addAction:okAction];
        [alertController addAction:cancleAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
        if ((self.oldPassText.text.length <4 || self.oldPassText.text.length >6)||(self.passText.text.length <4 || self.passText.text.length >6)) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入4-6字符的密码" preferredStyle:UIAlertControllerStyleAlert];
            
            //        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            //        [alertController addAction:okAction];
            [alertController addAction:cancleAction];
            
             [self presentViewController:alertController animated:YES completion:nil];
        }else if (![self.oldPassText.text isEqualToString:[MDDataBaseUtil password]]){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"原始密码输入有误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
//            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
                    [alertController addAction:okAction];
//            [alertController addAction:cancleAction];
             [self presentViewController:alertController animated:YES completion:nil];
        }else if ([self.passText.text isEqualToString:self.oldPassText.text]){
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"新密码与原始密码一致" preferredStyle:UIAlertControllerStyleAlert];
            
            //        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:nil];
            
            //        [alertController addAction:okAction];
            [alertController addAction:cancleAction];
             [self presentViewController:alertController animated:YES completion:nil];
        }else{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.mode = MBProgressHUDModeText;
            
            hud.margin = 10.f;
            hud.yOffset = 150.f;
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:2];
            AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
            NSMutableDictionary *params=[NSMutableDictionary dictionary];
            params[@"UserID"]=[MDDataBaseUtil userID];
            params[@"Password"]=self.passText.text;
            NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,RESET_PASSWORD_URL];
            [mgr POST:path parameters:params success:^(AFHTTPRequestOperation *operation,NSString *responseObject){
                if ([responseObject isEqualToString:@"success"]) {
                    [MDDataBaseUtil setPassword:self.passText.text];
                    hud.labelText = @"密码修改成功！";
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }failure:^(AFHTTPRequestOperation *operation,NSError *error){
               hud.labelText = @"密码修改失败！请重试";
            }];
            
        }
    }
    self.oldPassText.text=@"";
    self.passText.text=@"";
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
