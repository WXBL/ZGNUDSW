//
//  WXShoppingCarModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXShoppingCarModel.h"

@implementation WXShoppingCarModel
-(id)getShoppingCarDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXShoppingCarModel *model=[[WXShoppingCarModel alloc] init];
        model.ID=[((NSNumber *)dict[@"ID"]) stringValue];
        model.Merchant=[[[WXMerchantModel alloc] init] getMerchantDataWithDictionaryWithJSON:(dict[@"Merchant"]==[NSNull null])?@"":dict[@"Merchant"]];
        model.User=[[[WXUserModel alloc] init] getUserDataWithDictionaryJSON:(dict[@"User"]==[NSNull null])?@"":dict[@"User"]];
        model.Goods=[[[WXProductModel alloc] init] getProductDataWithDictionaryJSON:(dict[@"Goods"]==[NSNull null])?@"":dict[@"Goods"]];
        model.Goods_Color=(dict[@"Color"]==[NSNull null])?@"":dict[@"Color"];
        model.Goods_Size=(dict[@"Size"]==[NSNull null])?@"":dict[@"Size"];
        model.count=[((NSNumber *)dict[@"Number"]) stringValue];
        return model;
    }
    
    return nil;
}
-(id)getShoppingCarListWithArray:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getShoppingCarDataWithDictionaryJSON:dic]];
        }
        return data;
    }
    return nil;
}

@end
