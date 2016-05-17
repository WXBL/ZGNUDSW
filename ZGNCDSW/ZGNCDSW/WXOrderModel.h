//
//  WXOrderModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUserModel.h"
#import "WXMerchantModel.h"
#import "WXProductModel.h"
@interface WXOrderModel : NSObject
@property(strong,nonatomic)NSString *Indent_ID;
@property(strong,nonatomic)NSString *Indent_Number;
@property(strong,nonatomic)WXUserModel *User;
@property(strong,nonatomic)WXMerchantModel *Merchant;
@property(strong,nonatomic)WXProductModel *Goods;
@property(strong,nonatomic)NSString *Goods_Size;
@property(strong,nonatomic)NSString *Goods_Color;
@property(strong,nonatomic)NSString *Goods_Number;
@property(strong,nonatomic)NSString *Delivery_Time;
@property(strong,nonatomic)NSString *Place_On_Order_Time;
@property(strong,nonatomic)NSString *Shipments_Address;
@property(strong,nonatomic)NSString *Address;

-(id)getOrderDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getOrderListWithArray:(NSArray *)array;
@end
