//
//  WXAddressTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXAddressTableViewCell : UITableViewCell

//+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *phone;
@property (nonatomic,strong)UILabel *address;
@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic,strong)UIButton *deleteBtn;

@property(nonatomic,strong)UILabel *defaultAddress;
@property (nonatomic,strong)UIButton *defaultBtn;//勾选默认地址
@end
