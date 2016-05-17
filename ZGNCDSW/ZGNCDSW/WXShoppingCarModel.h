//
//  WXShoppingCarModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUserModel.h"
#import "WXMerchantModel.h"
#import "WXProductModel.h"
@interface WXShoppingCarModel : NSObject

@property(strong,nonatomic)NSString *ID;
@property(strong,nonatomic)WXUserModel *User;
@property(strong,nonatomic)WXMerchantModel *Merchant;
@property(strong,nonatomic)WXProductModel *Goods;
@property(strong,nonatomic)NSString *Goods_Size;
@property(strong,nonatomic)NSString *Goods_Color;
@property(strong,nonatomic)NSString *count;

-(id)getShoppingCarDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getShoppingCarListWithArray:(NSArray *)array;
@end
