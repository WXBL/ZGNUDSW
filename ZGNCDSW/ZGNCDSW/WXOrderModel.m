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
        model.Merchant=[[[WXMerchantModel alloc] init] getMerchantDataWithDictionaryWithJSON:(dict[@"Merchant"]==[NSNull null])?@"":dict[@"Merchant"]];
        model.User=[[[WXUserModel alloc] init] getUserDataWithDictionaryJSON:(dict[@"User"]==[NSNull null])?@"":dict[@"User"]];
        model.Goods=[[[WXProductModel alloc] init] getProductDataWithDictionaryJSON:(dict[@"Goods"]==[NSNull null])?@"":dict[@"Goods"]];
        model.Address=(dict[@"Address"]==[NSNull null])?@"":dict[@"Address"];
        model.Delivery_Time=(dict[@"Delivery_Time"]==[NSNull null])?@"":dict[@"Delivery_Time"];
        model.Place_On_Order_Time=(dict[@"Place_On_Order_Time"]==[NSNull null])?@"":dict[@"Place_On_Order_Time"];
        model.Shipments_Address=(dict[@"Shipments_Address"]==[NSNull null])?@"":dict[@"Shipments_Address"];
        model.Goods_Color=(dict[@"Goods_Color"]==[NSNull null])?@"":dict[@"Goods_Color"];
        model.Goods_Size=(dict[@"Goods_Size"]==[NSNull null])?@"":dict[@"Goods_Size"];
        model.Goods_Number=[((NSNumber *)dict[@"number"]) stringValue];
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
        return data;
    }
    return nil;
}
@end
