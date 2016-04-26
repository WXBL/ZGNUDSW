//
//  WXAddressModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddressModel.h"

@implementation WXAddressModel
-(id)getAddressDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXAddressModel *model=[[WXAddressModel alloc] init];
        model.Address_ID=[((NSNumber *)dict[@"Address_ID"]) stringValue];
        model.Specific_Address=(dict[@"Specific_Address"]==[NSNull null])?@"":dict[@"Specific_Address"];
        model.IS_default=(dict[@"IS_default"]==[NSNull null])?@"":dict[@"IS_default"];
        model.User_ID=[((NSNumber *)dict[@"User_ID"]) stringValue];
        return model;
    }
    return nil;
}
-(id)getAddressListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getAddressDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
