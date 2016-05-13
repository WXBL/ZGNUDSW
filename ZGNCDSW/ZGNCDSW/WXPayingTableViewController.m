//
//  WXPayingTableViewController.m
//  ZGNCDSW
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXPayingTableViewController.h"
#import "WXTopView.h"
@interface WXPayingTableViewController ()

@end

@implementation WXPayingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 50, screenWidth, screenHeigth-50);
    
<<<<<<< HEAD
//    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"待付款"];
//    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:topView];
=======
    WXTopView *topView = [[WXTopView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50) TitleText:@"待付款"];
    [topView.backButton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topView];
>>>>>>> origin/master
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
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
<<<<<<< HEAD
    
    cell.textLabel.text = @"asdf";
=======
>>>>>>> origin/master
    return cell;
}



<<<<<<< HEAD
//-(void)backButton:(id)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
=======
-(void)backButton:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
>>>>>>> origin/master
@end
