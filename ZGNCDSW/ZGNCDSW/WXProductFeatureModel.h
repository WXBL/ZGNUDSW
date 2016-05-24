//
//  WXProductFeatureModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/18.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXProductFeatureModel : NSObject
@property(strong,nonatomic)NSString *ID;
@property(strong,nonatomic)NSString *Goods_ID;
@property(strong,nonatomic)NSString *Goods_Size;
@property(strong,nonatomic)NSString *Goods_Color;
@property(strong,nonatomic)NSString *count;

-(id)getProductFeatureDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getProductFeatureListWithArray:(NSArray *)array;
@end
