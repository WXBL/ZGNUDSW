//
//  WXSizeModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXSizeModel : NSObject
@property(strong,nonatomic)NSString *Goods_Size_ID;
@property(strong,nonatomic)NSString *Goods_Size;
@property(strong,nonatomic)NSString *Goods_ID;
@property(strong,nonatomic)NSString *Type_ID;
@property(strong,nonatomic)NSString *pareter_ID;
-(id)getSizeDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getSizeListWithArrayJSON:(NSArray *)array;
@end
