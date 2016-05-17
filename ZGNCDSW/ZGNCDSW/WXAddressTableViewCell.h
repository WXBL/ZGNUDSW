//
//  WXAddressTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXAddressFrame.h"
#import "WXAddressModel.h"
@class WXAddressFrame;
@protocol WXAddressTableViewCellDelegate <NSObject>

-(void)WXAddressTableViewCell:(WXAddressModel *)addressmodel;

@end
@interface WXAddressTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)id<WXAddressTableViewCellDelegate>delegate;

@property (nonatomic,strong)WXAddressFrame *addressFrame;


@property (nonatomic,strong)WXAddressModel *addressModel;

@end
