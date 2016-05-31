//
//  WXNewsController.m
//  ZGNCDSW
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewsController.h"
#import "WXSearchBar.h"
#import "UIView+Extension.h"
#import "PrefixHeader.pch"
#import "WXNewsDetailViewController.h"
#import "WXTopView.h"
#import "WXNewsModel.h"
#import "WXImageModel.h"
@interface WXNewsController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITextField *newsText;

@property (nonatomic,strong)UITableView *newsTableView;
@property (nonatomic,strong)UIView *searchView;
@end

@implementation WXNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    [self addTitleView];
    
    [self addSearchView];
    [self addTableView];
}
-(void)addTitleView{
    
    WXTopView *topView=[[WXTopView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"行业资讯"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
    
}
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)addSearchView{
    //
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, screenWidth , 50)];
    self.searchView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.searchView];
    
    self.newsText = [[UITextField alloc]initWithFrame:CGRectMake(20,CGRectGetHeight(self.searchView.frame)-40-3, screenWidth - 40, 40)];
    self.newsText.placeholder = @"搜索农产品，景点，农业资讯";
    [self.newsText.layer setCornerRadius:10];
    self.newsText.backgroundColor = [UIColor whiteColor];
    self.newsText.delegate = self;
    [self.searchView addSubview: self.newsText];
    
    // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    searchIcon.width = 30;
    searchIcon.height = 30;
    searchIcon.contentMode = UIViewContentModeCenter;
    self.newsText.leftView = searchIcon;
    self.newsText.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
}


-(void)addTableView{
    
    self.newsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.searchView.frame), screenWidth, screenHeigth  ) style:UITableViewStylePlain];
    self.newsTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.newsTableView.tableFooterView = [[UIView alloc]init];
    self.newsTableView.delegate = self;
    self.newsTableView.dataSource = self;
    //隐藏UITableViewCell的分隔线
    [self.newsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.newsTableView];
    
    
    
    //    //添加标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,screenWidth / 2-10, 30)];
    titleLabel.text = [NSString stringWithFormat:@"行业资讯-共%ld条资讯",self.newsDataArray.count];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    //
    //        //添加最新／最热／精华新闻按钮
    //    UIButton *newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    newsButton.frame = CGRectMake(screenWidth / 1.8, 0, screenWidth / 2 /3 -10, 30);
    //    [newsButton setTitle:@"最新" forState:UIControlStateNormal];
    //    [newsButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [newsButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    //
    //    UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    hotButton.frame = CGRectMake(screenWidth / 1.8 + (screenWidth / 2 /3 -10), 0, screenWidth / 2 /3 -10, 30);
    //    [hotButton setTitle:@"最热" forState:UIControlStateNormal];
    //    [hotButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [hotButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    //
    //    UIButton *creamButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    creamButton.frame = CGRectMake(screenWidth / 1.8 +(screenWidth / 2 /3 -10)*2, 0, screenWidth / 2 /3 -10, 30);
    //    [creamButton setTitle:@"精华" forState:UIControlStateNormal];
    //    [creamButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [creamButton setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    //
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    //
    [titleView addSubview:titleLabel];
    //    [titleView addSubview:newsButton];
    //    [titleView addSubview:hotButton];
    //    [titleView addSubview:creamButton];
    //
    self.newsTableView.tableHeaderView = titleView;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.newsText resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.newsDataArray.count;
//        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellStr = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    if (self.newsDataArray.count>0) {
        WXNewsModel *model=[self.newsDataArray objectAtIndex:indexPath.row];
        UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, screenWidth - 20, 100)];
        newView.backgroundColor = [UIColor whiteColor];
        [newView.layer setCornerRadius:5];
        [cell addSubview:newView];
        
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        UIImageView *newImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetHeight(newView.frame)-10, CGRectGetHeight(newView.frame)-10)];
//        [newImage setImage:[UIImage imageNamed:[model.newsImgArr lastObject]]];
        WXImageModel *imgModel=[model.newsImgArr firstObject];
        NSData *imgData=[NSData dataWithContentsOfURL:[NSURL URLWithString:imgModel.Image_ur]];
        [newImage setImage:[UIImage imageWithData:imgData]];
        [newView addSubview:newImage];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(newImage.frame)+10, 5, CGRectGetWidth(newView.frame)-CGRectGetMaxX(newImage.frame)-20, 25)];
        titleLabel.text = model.Administrivia_Name;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16];
        [newView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame) , CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(titleLabel.frame), CGRectGetHeight(newView.frame)-CGRectGetMaxY(titleLabel.frame)-5)];
        detailLabel.text = [model.Administrivia_Content substringToIndex:40];
        detailLabel.textColor = [UIColor grayColor];
        detailLabel.textAlignment = NSTextAlignmentLeft;
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.numberOfLines = 0;
        [newView addSubview:detailLabel];
    }
    
    //    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    messageButton.frame = CGRectMake(screenWidth * 0.3, newView.frame.size.height - 35, 100, 30);
    //    [messageButton setTitle:@"消息" forState:UIControlStateNormal];
    //    [messageButton setTintColor:[UIColor grayColor]];
    
    
    //            [messageButton setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
    //    [newView addSubview:messageButton];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WXNewsDetailViewController *newDetailViewController = [[WXNewsDetailViewController alloc]init];
    newDetailViewController.theNew=[self.newsDataArray objectAtIndex:indexPath.row];
    [self presentViewController:newDetailViewController animated:YES completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

@end
