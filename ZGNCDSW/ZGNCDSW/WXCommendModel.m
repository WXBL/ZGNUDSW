//
//  WXCommendModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCommendModel.h"

@implementation WXCommendModel
-(id)getCommentDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXCommendModel *model=[[WXCommendModel alloc] init];
        model.Comment_ID=[((NSNumber *)dict[@"Comment_ID"]) stringValue];
        model.Comment_Content=(dict[@"Comment_Content"]==[NSNull null])?@"":dict[@"Comment_Content"];
        model.Comment_Time=(dict[@"Comment_Time"]==[NSNull null])?@"":dict[@"Comment_Time"];
        model.Indent_ID=[((NSNumber *)dict[@"Indent_ID"]) stringValue];
        return model;
    }

    return nil;
}
-(id)getcommentListWithArrayJSON:(NSArray *)array
{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getCommentDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
