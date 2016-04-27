//
//  WXMerchantModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXMerchantModel : NSObject
@property(strong,nonatomic)NSString *Merchant_ID;
@property(strong,nonatomic)NSString *Merchant_Name;
@property(strong,nonatomic)NSString *Password;
@property(strong,nonatomic)NSString *Tel;
@property(strong,nonatomic)NSString *Company_Name;
@property(strong,nonatomic)NSString *Company_Tell;
@property(strong,nonatomic)NSString *Company_Address;
@property(strong,nonatomic)NSString *Business_License;
@property(strong,nonatomic)NSString *Publish_Time;
@property(strong,nonatomic)NSString *Email;
@property(strong,nonatomic)NSString *Company_logo;
@property(strong,nonatomic)NSString *Now_address;
@property(strong,nonatomic)NSString *Note;

-(id)getMerchantDataWithDictionaryWithJSON:(NSDictionary *)dict;
-(id)getMerchantListWithArrayJSON:(NSArray *)array;
@end
