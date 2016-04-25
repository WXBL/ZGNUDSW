//
//  WXProductModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXProductModel.h"

@implementation WXProductModel
-(id)getProductDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXProductModel *model=[[WXProductModel alloc] init];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        model.Goods_Name=(dict[@"Goods_Name"]==[NSNull null])?@"":dict[@"Goods_Name"];
        model.Goods_Price=[((NSNumber *)dict[@"Goods_Price"]) stringValue];
        model.Goods_Number=[((NSNumber *)dict[@"Goods_Number"]) stringValue];
        model.Goods_Inventory=[((NSNumber *)dict[@"Goods_Inventory"]) stringValue];
        model.Goods_Average=[((NSNumber *)dict[@"Goods_Average"]) stringValue];
        model.Goods_last_time=(dict[@"Goods_last_time"]==[NSNull null])?@"":dict[@"Goods_last_time"];
        model.Merchant_ID=[((NSNumber *)dict[@"Merchant_ID"]) stringValue];
        model.Goods_Tyoe_ID=[((NSNumber *)dict[@"Goods_Tyoe_ID"]) stringValue];
        model.Goods_Pubilsh_time=(dict[@"Goods_Pubilsh_time"]==[NSNull null])?@"":dict[@"Goods_Pubilsh_time"];
        return  model;

    }
    return nil;
}
-(id)getProductListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getProductDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
