//
//  WXCommentTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXStatusModel.h"
#import "WXStatusFrame.h"
@class WXStatusFrame;
@interface WXCommentTableViewCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)WXStatusFrame *statusFrame;



@end
