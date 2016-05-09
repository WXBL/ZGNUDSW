//
//  WXBuyCartTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingBtn.h"
#import "WXShoppingModel.h"
@protocol WXBuyTableViewCellDelegate <NSObject>

-(void)WXShoppingTableViewCell:(WXShoppingModel *)model;

@end

@interface WXBuyCartTableViewCell : UITableViewCell

@property (nonatomic, weak) id<WXBuyTableViewCellDelegate>delegate;

@property (nonatomic, strong) WXShoppingCellModel *model;

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

//加入购物车的产品数量

@property (nonatomic,strong)NSString *numStr;

@property (nonatomic, assign) NSInteger numInteger;

@property (nonatomic, assign) NSInteger minInteget;

@end
