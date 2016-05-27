//
//  WXSetPassViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXSetPassViewController.h"
#import "WXTopView.h"
@interface WXSetPassViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)WXTopView *topView;

@property (nonatomic,strong)UITextField *oldPassText;
@property (nonatomic,strong)UITextField *passText;
@end

@implementation WXSetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
    oldPassView.backgroundColor = [UIColor whiteColor];
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
    [oldPassView addSubview:_oldPassText];
    
    UILabel *newPassLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, screenWidth*0.2-20, newPassView.frame.size.height)];
    newPassLabel.text = @"原密码";
    newPassLabel.textColor = [UIColor blackColor];
    newPassLabel.textAlignment = NSTextAlignmentLeft;
    newPassLabel.font = [UIFont systemFontOfSize:14];
    [newPassView addSubview:newPassLabel];
    
    self.passText = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newPassView.frame)+10, 0, screenWidth-(CGRectGetMaxX(newPassView.frame)+10), newPassView.frame.size.height)];
    self.passText.placeholder = @"新密码";
    self.passText.textColor = [UIColor blackColor];
    self.passText.font = [UIFont systemFontOfSize:13];
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    self.passText.clearButtonMode = UITextFieldViewModeAlways;
    self.passText.secureTextEntry = YES;//输入的字符是一个点（用于输入密码格式）
    [newPassView addSubview:self.passText];

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
