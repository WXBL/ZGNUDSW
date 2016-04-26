//
//  WXNewsModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewsModel.h"

@implementation WXNewsModel
-(id)getNewsDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXNewsModel *model=[[WXNewsModel alloc] init];
        model.Administrivia_ID=[((NSNumber *)dict[@"Administrivia_ID"]) stringValue];
        model.Administrivia_Name=(dict[@"Administrivia_Name"]==[NSNull null])?@"":dict[@"Administrivia_Name"];
        model.Administrivia_Content=(dict[@"Administrivia_Content"]==[NSNull null])?@"":dict[@"Administrivia_Content"];
        model.News_release_People_=(dict[@"News_release_People_"]==[NSNull null])?@"":dict[@"News_release_People_"];
        model.Release_Time=(dict[@"Release_Time"]==[NSNull null])?@"":dict[@"Release_Time"];
        return model;
    }
    return nil;
}
-(id)getNewsListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getNewsDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
