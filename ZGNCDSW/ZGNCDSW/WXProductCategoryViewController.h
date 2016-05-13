//
//  WXProductCategoryViewController.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXProductCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *productCategoryTableView;
@property(nonatomic,strong)NSMutableArray *productCategoryArray;


@end
