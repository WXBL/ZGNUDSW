//
//  MDDataBaseUtil.h
//  Hbsj
//
//  Created by 小小世界 on 14-10-26.
//  Copyright (c) 2014年 mSquare. All rights reserved.
//

#import <Foundation/Foundation.h>
#define M_USER_OBJECT @"m_user_object"
#define USER_ID @"UserID"
#define USER_NAME @"UserName"
#define PASSWORD @"Password"
#define TEL @"Tel"
#define IS_LOGIN @"is_login"
#define AGE @"Age"
#define SEX @"Sex"
#define REGIST_TIME @"Regist_time"
#define LAST_LOGIN_TIME @"Last_login_time"
#define USER_IMAGE @"User_image"
#define EMAIL @"Email"
#define LOGIN_ADDRESS @"Login_address"
#define NOW_ADDRESS @"Now_address"
#define NOTE @"Note"
#define LEVEL_ID @"Level_ID"
#define RANK_CONTENT @"Rank_Content"

@interface MDDataBaseUtil : NSObject

+ (NSString *) isLogin;

+ (void)setIsLogin:(NSString *) isLogin;

+ (id)userObject;
+ (void)setUserObject:(id)UserObject;
+(void)removeUserObject;

+ (id)userID;
+ (void)setUserID:(id)userID;
+(void)removeUserID;

+ (id)userName;
+ (void)setUserName:(id)userName;
+(void)removeUserName;

+ (id)password;
+ (void)setPassword:(id)password;
+(void)removePassword;


+ (id)tel;
+ (void)setTel:(id)tel;
+(void)removeTel;

+ (id)age;
+ (void)setAge:(id)age;
+(void)removeAge;

+ (id)sex;
+ (void)setSex:(id)sex;
+(void)removeSex;

+ (id)registTime;
+ (void)setRegistTime:(id)registTime;
+(void)removeRegisteTime;

+ (id)lastLoginTime;
+ (void)setLastLoginTime:(id)lastLoginTime;
+(void)removeLastLoginTime;

+ (id)userImage;
+ (void)setUserImage:(id)userImage;
+(void)removeUserImage;

+ (id)email;
+ (void)setEmail:(id)email;
+(void)removeEmail;

+ (id)loginAddress;
+ (void)setLoginAddress:(id)loginAddress;
+(void)removeLoginAddress;

+ (id)nowAddress;
+ (void)setNowAddress:(id)nowAddress;
+(void)removeNowAddress;

+ (id)note;
+ (void)setNote:(id)note;
+(void)removeNote;

+ (id)levelID;
+ (void)setLevelID:(id)levelID;
+(void)removeLevelID;

+ (id)rankContent;
+ (void)setRankContent:(id)rankContent;
+(void)removeRankContent;
@end
