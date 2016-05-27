//
//  WXMerchantListViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMerchantListViewController.h"
#import "WXTopView.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "WXMerchantViewController.h"
#import "WXMerchantModel.h"
#define MERCHANT_LIST_URL @""
@interface WXMerchantListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *merchantListArr;
@property(nonatomic,strong)UITableView *merchantTableView;
@end

@implementation WXMerchantListViewController
-(NSMutableArray *)merchantListArr{
    if (!_merchantListArr) {
        self.merchantListArr=[[NSMutableArray alloc] init];
    }
    return _merchantListArr;
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"商家列表"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTitleView];
    [self setMerchantListData];
    self.merchantTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-50)];
    self.merchantTableView.dataSource=self;
    self.merchantTableView.delegate=self;
    [self.view addSubview:self.merchantTableView];
    self.merchantTableView.tableFooterView=[[UIView alloc] init];
}
-(void)setMerchantListData{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,MERCHANT_LIST_URL];
    [mgr GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responseObject){
        WXMerchantModel *merchant=[[WXMerchantModel alloc] init];
        self.merchantListArr=[merchant getMerchantListWithArrayJSON:responseObject];
        [self.merchantTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求数据失败，请稍后重试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.merchantListArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"merchantListCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.numberOfLines=0;
    WXMerchantModel *merchant=[self.merchantListArr objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:merchant.Company_logo];
    cell.textLabel.text=merchant.Company_Name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WXMerchantViewController *merchantVC=[[WXMerchantViewController alloc] init];
    merchantVC.theMerchant=[self.merchantListArr objectAtIndex:indexPath.row];
    [self presentViewController:merchantVC animated:YES completion:nil];
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
