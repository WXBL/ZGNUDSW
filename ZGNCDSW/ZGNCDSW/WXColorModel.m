//
//  WXColorModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXColorModel.h"

@implementation WXColorModel
-(id)getColorDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXColorModel *model=[[WXColorModel alloc] init];
        model.Goods_Color_ID=[((NSNumber *)dict[@"Goods_Color_ID"]) stringValue];
        model.Goods_Color=(dict[@"Goods_Color"]==[NSNull null])?@"":dict[@"Goods_Color"];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        model.Type_ID=(dict[@"Type_ID"]==[NSNull null])?@"":dict[@"Type_ID"];
        return model;
    }
    return nil;
}
-(id)getColorListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getColorDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}

@end
