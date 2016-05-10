//
//  WXShoppingModel.m
//  ZGNCDSW
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXShoppingModel.h"

@implementation WXShoppingModel

@synthesize headClickState;

@synthesize headPriceDict;

-(instancetype)initWithShopDict:(NSDictionary *)dict
{
    self.headID = dict[@"headID"];
    self.headState = [dict[@"headState"] integerValue];

    
    self.headCellArray = [NSMutableArray arrayWithArray:[self ReturnData:dict[@"headCellArray"]]];
    
    self.headClickState = 0;
    
    self.headPriceDict = [[NSDictionary alloc] init];
    self.headPriceDict = @{
                           @"headTitle":[NSString stringWithFormat:@"选择必选单品,即可享受折优惠"],
                           @"footerTitle":@"小计:¥0.00",
                           };
    
    return self ;

}

-(NSArray *)ReturnData:(NSArray *)array{
    
    NSMutableArray *arrays= [[NSMutableArray alloc] init];
    for (NSDictionary *dict in array) {
        
        WXShoppingCellModel *model = [[WXShoppingCellModel alloc] initWithShopDict:dict];
        [arrays addObject:model];
        
    }
    
    return arrays;
}


@end

@implementation WXShoppingCellModel

@synthesize row;
@synthesize section;
@synthesize indexState;
@synthesize cellEditState;
@synthesize cellPriceDict;
@synthesize cellClickState;

-(instancetype)initWithShopDict:(NSDictionary *)dict{
    self.ID = dict[@"ID"];
    self.imageUrl = dict[@"imageUrl"];
    self.title = dict[@"title"];
    self.color = dict[@"color"];
    self.size = dict[@"size"];
    self.price =dict[@"price"];
    self.mustInteger = [dict[@"mustInteger"] integerValue];
    self.numInt = [dict[@"numInt"] integerValue];
//    self.inventoryInt = [dict[@"inventoryInt"] integerValue];
//    self.discountNum = dict[@"discountNum"];
    self.row = 0;
    self.section = 0;
    self.indexState = 0;
    self.cellClickState = 0;
    self.cellEditState = 0;
    self.cellPriceDict = [[NSDictionary alloc] init];
    return self ;

}

@end
