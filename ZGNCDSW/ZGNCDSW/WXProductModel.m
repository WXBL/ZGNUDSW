//
//  WXProductModel.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXProductModel.h"
#import "WXTypeModel.h"
#import "WXColorModel.h"
#import "WXImageModel.h"
@implementation WXProductModel

-(id)getProductDataWithDictionaryJSON:(NSDictionary *)dict
{
    if (dict) {
        WXProductModel *model=[[WXProductModel alloc] init];
        model.Goods_ID=[((NSNumber *)dict[@"Goods_ID"]) stringValue];
        model.Goods_Name=(dict[@"Goods_Name"]==[NSNull null])?@"":dict[@"Goods_Name"];
        model.Goods_Price=[((NSNumber *)dict[@"Goods_Price"]) stringValue];
        model.Goods_Number=[((NSNumber *)dict[@"Goods_Number"]) stringValue];
        model.Goods_Inventory=[((NSNumber *)dict[@"Goods_Inventory"]) stringValue];
        model.Goods_Average=[((NSNumber *)dict[@"Goods_Average"]) stringValue];
        model.Merchant_ID=[((NSNumber *)dict[@"Merchant_ID"]) stringValue];
        model.Goods_last_time=(dict[@"Goods_last_time"]==[NSNull null])?@"":dict[@"Goods_last_time"];
        model.Goods_Pubilsh_time=(dict[@"Goods_Pubilsh_time"]==[NSNull null])?@"":dict[@"Goods_Pubilsh_time"];
        NSMutableDictionary *typeDIct=(dict[@"Goods_Type"]==[NSNull null]?@"":dict[@"Goods_Type"]);
        model.Goods_Type=[[[WXTypeModel alloc] init] getTypeDataWithDictionaryWithJSON:typeDIct];
        NSMutableArray *colorArr=(dict[@"Goods_Color"]==[NSNull null]?@"":dict[@"Goods_Color"]);
        model.Goods_Color=[[[WXColorModel alloc]init] getColorListWithArrayJSON:colorArr];
        NSMutableArray *imageArr=(dict[@"Goods_Image"]==[NSNull null]?@"":dict[@"Goods_Image"]);
        model.Goods_Image=[[[WXImageModel alloc]init]getImageListDataWithArrayJSON:imageArr];
        return model;
    }
    
    return  nil;
}
-(id)getProductListWithArrayJSON:(NSArray *)array
{
    if (array) {
        NSMutableArray *data=[NSMutableArray array];
        for (NSDictionary *dic in array) {
            [data addObject:[self getProductDataWithDictionaryJSON:dic]];
        }
    }
    return nil;
}
@end
