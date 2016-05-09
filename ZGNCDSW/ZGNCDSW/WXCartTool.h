//
//  WXCartTool.h
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXCartToolDelegate <NSObject>

@optional
-(void)cartToolBar:(UIView *)toolBar didClickButton:(UIButton *)button;

@end

@interface WXCartTool : UIView

/**
 *  购物车中商品的被选中状态(NSString:@"YES"/@"NO")
 */
@property (nonatomic, strong) NSMutableArray *cellItems;
@property (nonatomic,weak)id <WXCartToolDelegate>delegate;

@end
