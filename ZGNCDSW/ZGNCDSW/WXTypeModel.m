//
//  WXTypeModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXTypeModel.h"

@implementation WXTypeModel

-(id)getTypeDataWithDictionaryWithJSON:(NSDictionary *)dict{
    if (dict) {
        WXTypeModel *model=[[WXTypeModel alloc] init];
        model.Type_ID=[((NSNumber *)dict[@"Type_ID"]) stringValue];
        model.Type_Name=(dict[@"Type_Name"]==[NSNull null])?@"":dict[@"Type_Name"];
        model.Note=(dict[@"Note"]==[NSNull null])?@"":dict[@"Note"];
        model.Parent_Class_ID=[((NSNumber *)dict[@"Parent_Class_ID"]) stringValue];
        return model;
    }
    return nil;
}
-(id)getTypeDataWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getTypeDataWithDictionaryWithJSON:dic]];
        }
    }
    return nil;
}
@end
