//
//  WXCollectionModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUserModel.h"
#import "WXMerchantModel.h"
#import "WXProductModel.h"
@interface WXCollectionModel : NSObject
@property(nonatomic,strong)NSString *Collection_ID;
@property(nonatomic,strong)NSString *Collection_Type;
@property(nonatomic,strong)WXUserModel *User;
@property(nonatomic,strong)WXMerchantModel *Merchant;
@property(nonatomic,strong)WXProductModel *Goods;
-(id)getCollectionDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getCollectionListWithArrayJSON:(NSArray *)array;
@end
