//
//  WXBuyCartTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingBtn.h"
@interface WXBuyCartTableViewCell : UITableViewCell


@property (nonatomic,strong)UIImageView *productImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *buyNum;
@property (nonatomic,strong)UIButton *reduceButton;
@property (nonatomic,strong)UIButton *addButton;
@property (nonatomic,strong)UILabel *buyNumLabel;
@property (nonatomic,strong)UIButton *deleteButton;

@property (nonatomic,strong)ShoppingBtn *chooseButton;

@property (nonatomic,strong)UIView *editView;
@end
