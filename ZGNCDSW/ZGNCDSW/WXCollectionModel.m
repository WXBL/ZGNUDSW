//
//  WXCollectionModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCollectionModel.h"

@implementation WXCollectionModel
-(id)getCollectionDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXCollectionModel *model=[[WXCollectionModel alloc]init];
        model.Collection_ID=[((NSNumber *)dict[@"Collection_ID"]) stringValue];
        model.Collection_Type=[((NSNumber *)dict[@"Collection_Type"]) stringValue];
        model.User=[[[WXUserModel alloc] init] getUserDataWithDictionaryJSON:(dict[@"username"]==[NSNull null])?@"":dict[@"username"]];
        model.Merchant=[[[WXMerchantModel alloc] init]getMerchantDataWithDictionaryWithJSON:(dict[@"username"]==[NSNull null])?@"":dict[@"username"]];
        model.Goods=[[[WXProductModel alloc] init]getProductDataWithDictionaryJSON:(dict[@"username"]==[NSNull null])?@"":dict[@"username"]];
    }
    return nil;
}
-(id)getCollectionListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getCollectionDataWithDictionaryJSON:dic]];
        }
        return data;
    }
    return nil;
}
@end
