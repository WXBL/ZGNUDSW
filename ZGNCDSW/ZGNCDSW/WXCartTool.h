//
//  WXCartTool.h
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXShoppingModel.h"
@protocol WXCartToolDelegate <NSObject>

@optional
-(void)cartToolBar:(UIView *)toolBar didClickButton:(UIButton *)button;

@end

@interface WXCartTool : UIView

/**
 *  购物车中商品的被选中状态(NSString:@"YES"/@"NO")
 */
@property (nonatomic, strong) NSMutableArray *cellItems;
@property (nonatomic,strong)id <WXCartToolDelegate>delegate;

@property (nonatomic, strong) WXShoppingCellModel *model;

@property (nonatomic,strong)UIImageView *chooseAllImage;//全选按钮
@property (nonatomic,strong)UILabel *chooseAll;//全选
@property (nonatomic,strong)UIButton *statement;//结算
@property (nonatomic,strong)UILabel *totalPrice;//合计
@property (nonatomic,strong)UIButton *allButton;
@end
