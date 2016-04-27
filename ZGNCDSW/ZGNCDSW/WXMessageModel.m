//
//  WXMessageModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXMessageModel.h"

@implementation WXMessageModel
-(id)getMessageDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXMessageModel *model=[[WXMessageModel alloc] init];
        model.Information_ID=[((NSNumber *)dict[@"Information_ID"]) stringValue];
        model.Information_Name=(dict[@"Information_Name"]==[NSNull null])?@"":dict[@"Information_Name"];
        model.Information_Content=(dict[@"Information_Content"]==[NSNull null])?@"":dict[@"Information_Content"];
        model.Publish_time=(dict[@"Publish_time"]==[NSNull null])?@"":dict[@"Publish_time"];
        model.Information_Image=(dict[@"Information_Image"]==[NSNull null])?@"":dict[@"Information_Image"];
        model.Post_message_ID=[((NSNumber *)dict[@"Post_message_ID"]) stringValue];
        model.receiving_information_ID=[((NSNumber *)dict[@"receiving_information_ID"]) stringValue];
        return model;
    }
    return nil;
}
-(id)getMessageListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getMessageDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
