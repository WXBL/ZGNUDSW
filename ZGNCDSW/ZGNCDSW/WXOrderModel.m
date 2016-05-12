//
//  WXOrderModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXOrderModel.h"

@implementation WXOrderModel
-(id)getOrderDataWithDictionaryJSON:(NSDictionary *)dict{
    if (dict) {
        WXOrderModel *model=[[WXOrderModel alloc] init];
        model.Indent_ID=[((NSNumber *)dict[@"Indent_ID"]) stringValue];
        model.Indent_Number=(dict[@"Indent_Number"]==[NSNull null])?@"":dict[@"Indent_Number"];
        model.Merchant_ID=[((NSNumber *)dict[@"Merchant_ID"]) stringValue];
        model.User_ID=[((NSNumber *)dict[@"User_ID"]) stringValue];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        model.Address_ID=[((NSNumber *)dict[@"Address_ID"]) stringValue];
        model.Delivery_Time=(dict[@"Delivery_Time"]==[NSNull null])?@"":dict[@"Delivery_Time"];
        model.Place_On_Order_Time=(dict[@"Place_On_Order_Time"]==[NSNull null])?@"":dict[@"Place_On_Order_Time"];
        model.Shipments_Address=(dict[@"Shipments_Address"]==[NSNull null])?@"":dict[@"Shipments_Address"];
        model.Goods_Color=(dict[@"Goods_Color"]==[NSNull null])?@"":dict[@"Goods_Color"];
        model.Goods_Size=(dict[@"Goods_Size"]==[NSNull null])?@"":dict[@"Goods_Size"];
        return model;
    }

    return nil;
}
-(id)getOrderListWithArray:(NSArray *)array{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getOrderDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
