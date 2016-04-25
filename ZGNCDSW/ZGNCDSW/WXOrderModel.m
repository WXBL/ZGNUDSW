//
//  WXOrderModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXOrderModel.h"

@implementation WXOrderModel
-(id)getOrderDataWithDictionaryJSON:(NSDictionary *)dict{
    
    if (dict) {
        WXOrderModel *model=[[WXOrderModel alloc] init];
        model.Indent_ID=[((NSNumber *)dict[@"Indent_ID"]) stringValue];
        model.Indent_Number=(dict[@"Indent_Number"]==[NSNull null])?@"":dict[@"Indent_Number"];
        model.User_ID=[((NSNumber *)dict[@"User_ID"]) stringValue];
        model.Merchant_ID=[((NSNumber *)dict[@"Merchant_ID"]) stringValue];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        model.Goods_Size_ID=[((NSNumber *)dict[@"Goods_Size_ID"]) stringValue];
        model.Goods_Color_ID=[((NSNumber *)dict[@"Goods_Color_ID"]) stringValue];
        model.Delivery_Time=(dict[@"Delivery_Time"]==[NSNull null])?@"":dict[@"Delivery_Time"];
        model.Place_On_Order_Time=(dict[@"Place_On_Order_Time"]==[NSNull null])?@"":dict[@"Place_On_Order_Time"];
        model.Shipments_Address=(dict[@"Shipments_Address"]==[NSNull null])?@"":dict[@"Shipments_Address"];
        model.Delivery_Address=(dict[@"Delivery_Address"]==[NSNull null])?@"":dict[@"Delivery_Address"];
        return  model;
        
    }
    return nil;
}
-(id)getOrderListWithArrayJSON:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getOrderDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
