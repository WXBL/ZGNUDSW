//
//  WXUserModel.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXUserModel : NSObject
@property(strong,nonatomic)NSString *UserID;
@property(strong,nonatomic)NSString *UserName;
@property(strong,nonatomic)NSString *Password;
@property(strong,nonatomic)NSString *Tel;
@property(strong,nonatomic)NSString *Age;
@property(strong,nonatomic)NSString *Sex;
@property(strong,nonatomic)NSString *Regist_time;
@property(strong,nonatomic)NSString *Last_login_time;
@property(strong,nonatomic)NSString *User_image;
@property(strong,nonatomic)NSString *Email;
@property(strong,nonatomic)NSString *Login_address;
@property(strong,nonatomic)NSString *Now_address;
@property(strong,nonatomic)NSString *Note;
@property(strong,nonatomic)NSString *Level_ID;

-(id)getUserDataWithDictionaryJSON:(NSDictionary *)dict;
-(id)getUserDataWithArrayJSON:(NSArray *)array;
@end
