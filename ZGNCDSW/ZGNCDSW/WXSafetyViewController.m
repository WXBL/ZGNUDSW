//
//  WXSafetyViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXSafetyViewController.h"
#import "WXTopView.h"
#import "WXSetPassViewController.h"
@interface WXSafetyViewController ()

@property (nonatomic,strong)WXTopView *topView;


@end

@implementation WXSafetyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self addNavBar];
    
    UIView *setPassView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10, screenWidth, 40)];
    setPassView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:setPassView];
    
    UIButton *setPassButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, screenWidth-10, setPassView.frame.size.height)];
    [setPassButton setTitle:@"修改密码" forState:UIControlStateNormal];
    [setPassButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    setPassButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [setPassButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [setPassButton addTarget:self action:@selector(ClickSetPassBtn:) forControlEvents:UIControlEventTouchUpInside];
    [setPassView addSubview:setPassButton];
}

-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"账户安全"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView =topView;
}

-(void)ClickSetPassBtn:(UIButton *)sender{
    WXSetPassViewController *setPass = [[WXSetPassViewController alloc]init];
    [self presentViewController:setPass animated:YES completion:nil];
    
}


-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
