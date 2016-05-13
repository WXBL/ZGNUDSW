//
//  WXAddressModel.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddressModel.h"

@implementation WXAddressModel
-(id)getAddressDataWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getAddressDataWithDictionaryJSON:dic]];
        }
        return data;
    }
    
    return nil;
}
-(id)getAddressDataWithDictionaryJSON:(NSDictionary *)dict{
    
    if(dict){
        WXAddressModel *model=[[WXAddressModel alloc] init];
        model.Address_ID=[((NSNumber *)dict[@"Address_ID"]) stringValue];
        model.Specific_Address=(dict[@"Specific_Address"]==[NSNull null])?@"":dict[@"Specific_Address"];
        model.IS_default=(dict[@"IS_default"]==[NSNull null])?@"":dict[@"IS_default"];
        model.addNumber=[((NSNumber *)dict[@"addNumber"]) stringValue];
        model.Phone=(dict[@"Phone"]==[NSNull null])?@"":dict[@"Phone"];
        model.addName=(dict[@"addName"]==[NSNull null])?@"":dict[@"addName"];
        model.username=(dict[@"username"]==[NSNull null])?@"":dict[@"username"];
        model.User_ID=[((NSNumber *)dict[@"User_ID"]) stringValue];
        return model;
    }
    return nil;
}
@end
