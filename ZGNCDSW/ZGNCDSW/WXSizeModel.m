//
//  WXSizeModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXSizeModel.h"

@implementation WXSizeModel
-(id)getSizeDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXSizeModel *model=[[WXSizeModel alloc] init];
        model.Goods_Size_ID=[((NSNumber *)dict[@"Goods_Size_ID"]) stringValue];
        model.Goods_Size=(dict[@"Goods_Size"]==[NSNull null])?@"":dict[@"Goods_Size"];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        model.Type_ID=[((NSNumber *)dict[@"Type_ID"]) stringValue];
        model.pareter_ID=[((NSNumber *)dict[@"pareter_ID"]) stringValue];
        return model;
    }
    return nil;
}
-(id)getSizeListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getSizeDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
