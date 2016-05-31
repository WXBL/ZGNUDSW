//
//  WXAboutViewController.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAboutViewController.h"
#import "WXTopView.h"
@interface WXAboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *aboutTableView;
@property (nonatomic,strong)WXTopView *topView;

@property (nonatomic,strong)UILabel *editionLabel;
@property (nonatomic,strong)UILabel *edition;

@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *phone;

@property (nonatomic,strong)UILabel *urlLabel;
@property (nonatomic,strong)UILabel *url;


@end

@implementation WXAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavBar];

    [self addTableView];
    
    [self addTableHeaderView];
    
    [self addFooterView];
}


-(void)addNavBar{
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"关于我们"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    self.topView = topView;
}

-(void)addTableView{
    self.aboutTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), screenWidth, screenHeigth-self.topView.frame.size.height-100) style:UITableViewStylePlain];
    self.aboutTableView.delegate = self;
    self.aboutTableView.dataSource = self;
    self.aboutTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.aboutTableView.scrollEnabled = NO;
    [self.view addSubview:self.aboutTableView];
}

-(void)addTableHeaderView{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 150)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.aboutTableView.tableHeaderView = headerView;
    
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth *0.4, 20, screenWidth*0.2, screenWidth*0.2)];
    [headerImage setImage:[UIImage imageNamed:@"news_list1"]];
    [headerView addSubview: headerImage];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(headerImage.frame)+10, screenWidth, 30)];
    titleLabel.text = @"中国农村电商网";
    titleLabel.textColor = [UIColor colorWithRed:0.4 green:0.7 blue:0.4 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:titleLabel];
    
    
}

-(void)addFooterView{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth-100, screenWidth, 100)];
    footerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview: footerView];
    
    UILabel *copyrighted = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, screenWidth, 30)];
    copyrighted.text = @"天津万象包罗科技有限公司 版权所有";
    copyrighted.textColor = [UIColor blackColor];
    copyrighted.textAlignment = NSTextAlignmentCenter;
    copyrighted.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:copyrighted];
    
}

#pragma mark - tableViewDataSource 数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section ==1) {
//        NSString *title = @"热门推荐";
//        return title;
//    }
//    return nil;
//    
//}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"AboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = [NSString stringWithFormat:@"软件版本：%@",kVersionId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
                break;
             case 1:
            {
                cell.textLabel.text = [NSString stringWithFormat:@"手机访问：www.zgds.com"];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
                break;
             case 2:
            {
                cell.textLabel.text = @"客服电话: 12342341";
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
                break;
            default:
                break;
        }
    
    return cell;
}


#pragma mark - tableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
