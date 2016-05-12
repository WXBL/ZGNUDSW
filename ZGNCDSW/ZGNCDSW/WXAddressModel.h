//
//  WXAddressModel.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXAddressModel : NSObject
@property(strong,nonatomic)NSString *Address_ID;
@property(strong,nonatomic)NSString *Specific_Address;//详细地址
@property(strong,nonatomic)NSString *IS_default;
@property(strong,nonatomic)NSString *User_ID;
@property(strong,nonatomic)NSString *addNumber;//邮编
@property(strong,nonatomic)NSString *Phone;
@property(strong,nonatomic)NSString *addName;//所在地区
@property(strong,nonatomic)NSString *username;//收件人
-(id)getAddressDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getAddressListDataWithArrayJSON:(NSArray *)array;
@end
