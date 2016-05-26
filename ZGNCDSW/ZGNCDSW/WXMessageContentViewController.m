//
//  WXMessageContentViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMessageContentViewController.h"
#import "WXTopView.h"
#import "UILabel+WXStringFrame.h"
@interface WXMessageContentViewController ()

@end

@implementation WXMessageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self addTitleView];
    [self addContent];
}
-(void)addContent{
    UIScrollView *scrollerView=[[UIScrollView alloc] initWithFrame:CGRectMake(5, 60, screenWidth-10, screenHeigth-70)];
    scrollerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:scrollerView];
    [scrollerView.layer setCornerRadius:5];
    [scrollerView.layer setMasksToBounds:YES];
    
    UILabel *ContentLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, screenWidth-20, screenHeigth-10)];
    ContentLbl.numberOfLines=0;
    ContentLbl.textAlignment=NSTextAlignmentLeft;
    ContentLbl.textColor=[UIColor blackColor];
    ContentLbl.backgroundColor=[UIColor clearColor];

    ContentLbl.font=[UIFont systemFontOfSize:16];
    NSString *contentStr=self.theMessage.Information_Content;
    ContentLbl.text=contentStr;
    CGSize size=[ContentLbl boundingRectWithSize:CGSizeMake(screenWidth-20, 0)];
    ContentLbl.frame=CGRectMake(10, 10, size.width, size.height);
    
    [scrollerView addSubview:ContentLbl];
    CGFloat y=CGRectGetMaxY(ContentLbl.frame);
    scrollerView.contentSize=CGSizeMake(screenWidth-10, y);
    if (y<CGRectGetHeight(scrollerView.frame)) {
        scrollerView.frame=CGRectMake(5, 60, screenWidth-10, y+10);
    }
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"消息详情"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
