//
//  WXCommendModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCommendModel.h"
#import "WXOrderModel.h"
#import "WXImageModel.h"
@implementation WXCommendModel
-(id)getCommentDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXCommendModel *model=[[WXCommendModel alloc] init];
        model.Comment_ID=[((NSNumber *)dict[@"Comment_ID"]) stringValue];
        model.Comment_Content=(dict[@"Comment_Content"]==[NSNull null])?@"":dict[@"Comment_Content"];
        model.Comment_Time=(dict[@"Comment_Time"]==[NSNull null])?@"":dict[@"Comment_Time"];
        NSMutableDictionary *indentDic=(dict[@"Indent"]==[NSNull null])?@"":dict[@"Indent"];
        model.Indent=[[[WXOrderModel alloc] init] getOrderDataWithDictionaryJSON:indentDic];
        NSMutableArray *imgArr=(dict[@"Comment_Image"]==[NSNull null])?@"":dict[@"Comment_Image"];
        model.Comment_Image=[[[WXImageModel alloc] init] getImageListDataWithArrayJSON:imgArr];
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
        return data;
    }
    return nil;
}
@end
