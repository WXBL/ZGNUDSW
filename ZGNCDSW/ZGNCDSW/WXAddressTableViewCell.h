//
//  WXAddressTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXAddressFrame.h"
@class WXAddressFrame;
@interface WXAddressTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)WXAddressFrame *addressFrame;


@end
