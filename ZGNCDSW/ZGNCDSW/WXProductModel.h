//
//  WXProductModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXProductModel : NSObject
@property(strong,nonatomic)NSString *Goods_ID;
@property(strong,nonatomic)NSString *Goods_Name;
@property(strong,nonatomic)NSString *Goods_Price;
@property(strong,nonatomic)NSString *Goods_Number;
@property(strong,nonatomic)NSString *Goods_Inventory;
@property(strong,nonatomic)NSString *Goods_Average;
@property(strong,nonatomic)NSString *Goods_last_time;
@property(strong,nonatomic)NSString *Merchant_ID;
@property(strong,nonatomic)NSString *Goods_Tyoe_ID;
@property(strong,nonatomic)NSString *Goods_Pubilsh_time;


-(id)getProductDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getProductListWithArrayJSON:(NSArray *)array;
@end
