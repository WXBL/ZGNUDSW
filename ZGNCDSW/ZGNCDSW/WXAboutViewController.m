//
//  WXAboutViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAboutViewController.h"
#import "WXTopView.h"
@interface WXAboutViewController ()

@end

@implementation WXAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavBar];
    UITextView * aboutTextView=[[UITextView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-50)];
    [aboutTextView setEditable:NO];
    aboutTextView.text=@"asda";
    [self.view addSubview:aboutTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"关于我们"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
