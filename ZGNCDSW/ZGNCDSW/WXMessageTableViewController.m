//
//  WXMessageTableViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMessageTableViewController.h"
#import "WXMessageContentViewController.h"
@interface WXMessageTableViewController ()

@property (nonatomic,strong)NSMutableArray *messageArray;
@end

@implementation WXMessageTableViewController

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces=NO;
    self.messageArray = [NSMutableArray array];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
//    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.imageView.image=[UIImage imageNamed:@"icon_weibo.png"];
    cell.textLabel.text = @"今日消息";
    cell.detailTextLabel.text=@"asdasdsa";
    cell.detailTextLabel.textColor=[UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WXMessageContentViewController *messageContentVC=[[WXMessageContentViewController alloc] init];
    [self presentViewController:messageContentVC animated:YES completion:nil];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}



@end
