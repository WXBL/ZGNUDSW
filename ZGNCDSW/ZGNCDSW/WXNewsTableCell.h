//
//  WXNewsTableCell.h
//  ZGNCDSW
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXNewsTableCell : UITableViewCell



@property (nonatomic,strong) UIImageView *newsImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UIButton *messageButton;
@property (nonatomic,strong)UILabel *messageNum;
@property (nonatomic,strong)UIButton *keepButton;
@property (nonatomic,strong)UILabel *keepNum;
@property (nonatomic,strong)UIButton *shareButton;
@end
