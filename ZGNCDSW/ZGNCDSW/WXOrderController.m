//
//  WXOrderController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXOrderController.h"
#import "WXTopView.h"
#import "WXPayingTableViewController.h"
#import "WXReceivingTableViewController.h"
#import "WXCommendTableViewController.h"
#import "WXReturnrefundTableVC.h"
#import "XFSegementView.h"
#import "WXRecommendTableViewCell.h"
#import "WXCommendTableViewController.h"
#import "XFSegementView.h"

@interface WXOrderController ()<TouchLabelDelegate>{
    XFSegementView *segementView;
    
}

@property(nonatomic,strong)UIButton *orderBtn;
@end

@implementation WXOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"待付款"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
    
    [self showOrderdetailView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)showOrderdetailView
{
    segementView = [[XFSegementView alloc]initWithFrame:CGRectMake(0, 50, screenWidth, 50)];
    segementView.backgroundColor = [UIColor whiteColor];
    segementView.titleArray = @[@"待付款",@"待收货",@"待评价",@"退货／退款"];
    [segementView.scrollLine setBackgroundColor:[UIColor colorWithRed:0.6 green:0.2 blue:0.2 alpha:1]];
    segementView.titleSelectedColor = [UIColor redColor];
    segementView.touchDelegate = self;
    NSLog(@"%d",self.theTag);

//
    [segementView selectLabelWithIndex:self.theTag];
    [self.view addSubview:segementView];
   
    
}

- (void)touchLabelWithIndex:(NSInteger)index{
    NSLog(@"我是第%ld个label",index);
//    if (index ==0) {
//        WXPayingTableViewController *payViewController = [[WXPayingTableViewController alloc]init];
//        payViewController.view.frame = CGRectMake(0, 100, screenWidth, screenHeigth-100);
//        [self.view addSubview:payViewController.tableView];
////        [payViewController.tableView reloadData];
//    }else if (index ==1){
//        WXReceivingTableViewController *receivingViewController = [[WXReceivingTableViewController alloc]init];
//        receivingViewController.view.frame = CGRectMake(0, 100, screenWidth, screenHeigth-100);
//        [self.view addSubview:receivingViewController.tableView];
////        [receivingViewController.tableView reloadData];
//    }else if (index == 2){
//        WXCommendTableViewController *commendViewController = [[WXCommendTableViewController alloc]init];
//        commendViewController.view.frame = CGRectMake(0, 100, screenWidth, screenHeigth-200);
//        [self.view addSubview:commendViewController.tableView];
//    }else{
//        WXReturnrefundTableVC *returnRefundTVC = [[WXReturnrefundTableVC alloc]init];
//        returnRefundTVC.view.frame = CGRectMake(0, 100, screenWidth, screenHeigth);
//        [self.view addSubview:returnRefundTVC.tableView];
//    }
    
    
}



-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
