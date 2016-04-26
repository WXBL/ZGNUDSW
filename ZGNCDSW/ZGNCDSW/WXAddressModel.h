//
//  WXAddressModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXAddressModel : NSObject
@property(strong,nonatomic)NSString *Address_ID;
@property(strong,nonatomic)NSString *Specific_Address;
@property(strong,nonatomic)NSString *IS_default;
@property(strong,nonatomic)NSString *User_ID;

-(id)getAddressDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getAddressListWithArrayJSON:(NSArray *)array;
@end
