//
//  WXUserModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXUserModel.h"
#import "PrefixHeader.pch"
@implementation WXUserModel

-(id)getUserDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXUserModel *model=[[WXUserModel alloc] init];
        model.UserID=[((NSNumber *)dict[@"UserID"]) stringValue];
        model.UserName=(dict[@"UserName"]==[NSNull null])?@"":dict[@"UserName"];
        model.Password=(dict[@"Password"]==[NSNull null])?@"":dict[@"Password"];
        model.Tel=(dict[@"Tel"]==[NSNull null])?@"":dict[@"Tel"];
        model.Age=[((NSNumber *)dict[@"Age"]) stringValue];
        model.Sex=[((NSNumber *)dict[@"Sex"]) stringValue];
        model.Regist_time=(dict[@"Regist_time"]==[NSNull null])?@"":dict[@"Regist_time"];
        model.Last_login_time=(dict[@"Last_login_time"]==[NSNull null])?@"":dict[@"Last_login_time"];
        model.User_image=(dict[@"User_image"]==[NSNull null])?@"":dict[@"User_image"];
        model.Email=(dict[@"Email"]==[NSNull null])?@"":dict[@"Email"];
        model.Login_address=(dict[@"Login_address"]==[NSNull null])?@"":dict[@"Login_address"];
        model.Now_address=(dict[@"Now_address"]==[NSNull null])?@"":dict[@"Now_address"];
        model.Note=(dict[@"Note"]==[NSNull null])?@"":dict[@"Note"];
        model.Level_ID=[((NSNumber *)dict[@"Level_ID"]) stringValue];
        model.Rank_Content=(dict[@"Rank_Content"]==[NSNull null])?@"":dict[@"Rank_Content"];
        return  model;
    }
    return nil;
}
-(id)getUserDataWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getUserDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}

@end
