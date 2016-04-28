//
//  WXMerchantModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMerchantModel.h"

@implementation WXMerchantModel
-(id)getMerchantDataWithDictionaryWithJSON:(NSDictionary *)dict{
    if (dict) {
        WXMerchantModel *model=[[WXMerchantModel alloc] init];
        model.Merchant_ID=[((NSNumber *)dict[@"Merchant_ID"]) stringValue];
        model.Merchant_Name=(dict[@"Merchant_Name"]==[NSNull null])?@"":dict[@"Merchant_Name"];
        model.Password=(dict[@"Password"]==[NSNull null])?@"":dict[@"Password"];
        model.Tel=(dict[@"Tel"]==[NSNull null])?@"":dict[@"Tel"];
        model.Company_Name=(dict[@"Company_Name"]==[NSNull null])?@"":dict[@"Company_Name"];
        model.Company_Tell=(dict[@"Company_Tell"]==[NSNull null])?@"":dict[@"Company_Tell"];
        model.Company_Address=(dict[@"Company_Address"]==[NSNull null])?@"":dict[@"Company_Address"];
        model.Email=(dict[@"Email"]==[NSNull null])?@"":dict[@"Email"];
        model.Business_License=(dict[@"Business_License"]==[NSNull null])?@"":dict[@"Business_License"];
        model.Publish_Time=(dict[@"Publish_Time"]==[NSNull null])?@"":dict[@"Publish_Time"];
        model.Note=(dict[@"Note"]==[NSNull null])?@"":dict[@"Note"];
        model.Company_logo=(dict[@"Company_logo"]==[NSNull null])?@"":dict[@"Company_logo"];
        return model;
    }
    return nil;
}
-(id)getMerchantListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getMerchantDataWithDictionaryWithJSON:dic]];
        }
    }
    return nil;
}
@end
