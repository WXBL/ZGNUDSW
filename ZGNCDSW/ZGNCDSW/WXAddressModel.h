//
//  WXAddressModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXAddressModel : NSObject
@property(copy,nonatomic)NSString *Address_ID;
@property(copy,nonatomic)NSString *Specific_Address;//详细地址
@property(copy,nonatomic)NSString *User_ID;
@property(copy,nonatomic)NSString *addNumber;//邮编
@property(copy,nonatomic)NSString *Phone;
@property(copy,nonatomic)NSString *addName;//所在地区
@property(copy,nonatomic)NSString *username;//收件人
@property(copy,nonatomic)NSString *IS_default;

@property (assign,nonatomic)NSInteger addressClickState;


-(id)getAddressDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getAddressDataWithArrayJSON:(NSArray *)array;
@end
