//
//  WXProductCategoryViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXProductCategoryViewController.h"
#import "WXTopView.h"
#import "WXFarmImportsController.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "WXTypeModel.h"
@interface WXProductCategoryViewController ()

@end

@implementation WXProductCategoryViewController
-(NSMutableArray *)productCategoryArray{
    if (!_productCategoryArray) {
        self.productCategoryArray=[NSMutableArray array];
    }
    return _productCategoryArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTitleView];
    [self setCatagoryData];
    [self addContentView];
    
}
-(void)setCatagoryData{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSString *path=[NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,@""];
    [mgr GET:path parameters:nil success:^(AFHTTPRequestOperation *operation,NSArray *responseObject){
        WXTypeModel *model=[[WXTypeModel alloc] init];
        self.productCategoryArray=[model getTypeDataWithArrayJSON:responseObject];
        [self.productCategoryTableView reloadData];
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求数据失败，请稍后重试" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"关闭", nil];
        [alertView show];
    }];
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"类别"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
}
-(void)addContentView{
    self.productCategoryTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 50, screenWidth, screenHeigth-50)];
    self.productCategoryTableView.delegate=self;
    self.productCategoryTableView.dataSource=self;
    self.productCategoryTableView.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:self.productCategoryTableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productCategoryArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WXFarmImportsController *farmImportVC=[[WXFarmImportsController alloc] init];
    WXTypeModel *typeModel=[self.productCategoryArray objectAtIndex:indexPath.row];
    farmImportVC.typeModel=typeModel;
    [self presentViewController:farmImportVC animated:YES completion:nil];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"productCategoryCellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text=((WXTypeModel *)[self.productCategoryArray objectAtIndex:indexPath.row]).Type_Name;
    return cell;
}


-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
