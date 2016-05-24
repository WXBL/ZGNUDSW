//
//  WXProductFeatureModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXProductFeatureModel.h"

@implementation WXProductFeatureModel
-(id)getProductFeatureDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXProductFeatureModel *model=[[WXProductFeatureModel alloc] init];
        model.ID=[((NSNumber *)dict[@"ID"]) stringValue];
        model.Goods_ID=[((NSNumber *)dict[@"ID"]) stringValue];
        model.Goods_Color=(dict[@"Color"]==[NSNull null])?@"":dict[@"Color"];
        model.Goods_Size=(dict[@"Size"]==[NSNull null])?@"":dict[@"Size"];
        model.count=[((NSNumber *)dict[@"Number"]) stringValue];
        return model;
    }
    
    return nil;
}

-(id)getProductFeatureListWithArray:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getProductFeatureDataWithDictionaryJSON:dic]];
        }
        return data;
    }
    return nil;
}
@end
