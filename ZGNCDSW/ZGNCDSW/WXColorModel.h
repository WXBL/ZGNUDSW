//
//  WXColorModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXColorModel : NSObject
@property(strong,nonatomic)NSString *Goods_Color_ID;
@property(strong,nonatomic)NSString *Goods_Color;
@property(strong,nonatomic)NSString *Goods_ID;
@property(strong,nonatomic)NSString *Type_ID;
-(id)getColorDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getColorListWithArrayJSON:(NSArray *)array;
@end
