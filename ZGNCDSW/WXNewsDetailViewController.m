//
//  WXNewsDetailViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewsDetailViewController.h"
#import "WXTopView.h"
#import "WXImageModel.h"
#import "UILabel+WXStringFrame.h"
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
//    self.newsTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth - 50)];
//    self.newsTextView.delegate = self;
//    [self.view addSubview:self.newsTextView];
//    
//    self.newsTextView.text = @"askelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkjaaskelfasldjflkasdfkja;lskdjflkasldf";
//    self.newsTextView.textAlignment = NSTextAlignmentLeft;
//    self.newsTextView.textColor = [UIColor grayColor];
//    self.newsTextView.font = [UIFont systemFontOfSize:100];
//    //设置文字编辑使能属性，是否允许编辑（＝no时，只用来显示，依然可以选择和拷贝）
//    self.newsTextView.editable = NO;
//    
//    //修复文本框是偏移（下移）
//    self.automaticallyAdjustsScrollViewInsets = NO;
    UILabel *titleLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth-10, 40)];
    titleLbl.text=self.theNew.Administrivia_Name;
    titleLbl.numberOfLines=0;
    titleLbl.textAlignment=NSTextAlignmentCenter;
    titleLbl.textColor=[UIColor grayColor];
    titleLbl.font=[UIFont systemFontOfSize:20];
    [self.scrollView addSubview:titleLbl];
    
    UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLbl.frame), screenWidth-20, screenWidth-10)];
    
    imgView.image=[UIImage imageNamed:((WXImageModel *)[self.theNew.newsImgArr firstObject]).Image_ur];
    [self.scrollView addSubview:imgView];
    
    UILabel *newsContentLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imgView.frame), screenWidth-20, screenHeigth)];
    newsContentLbl.numberOfLines=0;
    newsContentLbl.textAlignment=NSTextAlignmentLeft;
    newsContentLbl.textColor=[UIColor grayColor];
    newsContentLbl.font=[UIFont systemFontOfSize:16];
    NSString *contentStr=self.theNew.Administrivia_Content;
    newsContentLbl.text=contentStr;
    CGSize size=[newsContentLbl boundingRectWithSize:CGSizeMake(screenWidth-20, 0)];
    newsContentLbl.frame=CGRectMake(10, CGRectGetMaxY(imgView.frame), size.width, size.height);
    
    [self.scrollView addSubview:newsContentLbl];
    self.scrollView.contentSize=CGSizeMake(screenWidth, CGRectGetMaxY(newsContentLbl.frame));
    
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
