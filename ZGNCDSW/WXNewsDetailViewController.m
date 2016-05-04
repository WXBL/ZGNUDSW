//
//  WXNewsDetailViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewsDetailViewController.h"
#import "WXTopView.h"

@interface WXNewsDetailViewController ()<UIScrollViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UITextView *newsTextView;

@end

@implementation WXNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"新闻资讯"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    [self addScrollView];
    [self addContentText];
}

/**
 * 添加UIScrollView
 */
-(void)addScrollView{
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.scrollView.frame = CGRectMake(0, 50, screenWidth, screenHeigth - 50);
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
}

/**
 * 添加内容
 */
-(void)addContentText{
    self.newsTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth - 50)];
    self.newsTextView.delegate = self;
    [self.view addSubview:self.newsTextView];
    
    self.newsTextView.text = @"askelfasldjflkasdfkja;lskdjflkasldf";
    self.newsTextView.textAlignment = NSTextAlignmentLeft;
    self.newsTextView.textColor = [UIColor grayColor];
    self.newsTextView.font = [UIFont systemFontOfSize:20];
    //设置文字编辑使能属性，是否允许编辑（＝no时，只用来显示，依然可以选择和拷贝）
    self.newsTextView.editable = NO;
    
    //修复文本框是偏移（下移）
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)textViewDidChangeSelection:(UITextView *)textView
{
    NSLog(@"选中内容");
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
