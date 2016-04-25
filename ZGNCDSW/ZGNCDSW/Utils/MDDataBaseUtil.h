//
//  MDDataBaseUtil.h
//  Hbsj
//
//  Created by 小小世界 on 14-10-26.
//  Copyright (c) 2014年 mSquare. All rights reserved.
//

#import <Foundation/Foundation.h>
#define M_USER_OBJECT @"m_user_object"
#define M_USER_ID @"m_user_ID"
#define M_USER_TYPE @"m_user_Type"
#define M_USER_UIN @"m_user_UIN"
#define M_USER_LGOGIN_NAME @"m_user_login_name"
#define IS_LOGIN @"is_login"
#define M_LONGTITUDE @"m_longtitude"
#define M_LATITUDE @"m_latitude"
#define M_LIST_KEYWORD @"m_keyword"
#define M_LIST_KEYWORD_ATT @"m_keyword_att"
#define M_LIST_VC_INDEX @"m_list_index"
#define M_USER_PASSWORD @"m_user_password"
#define M_USER_PHONE @"m_user_phone"
#define M_UUID @"m_uuid"
#define M_USER_COINS @"m_user_coins"

@interface MDDataBaseUtil : NSObject

+ (NSString *) isLogin;

+ (void)setIsLogin:(NSString *) isLogin;

+ (id)userObject;
+ (void)setUserObject:(id)UserObject;

+ (id)userID;
+ (void)setUserID:(id)userID;

+ (id)userUIN;
+ (void)setUserUIN:(id)userUIN;

+ (id)userType;
+ (void)setUserType:(id)userType;


+ (id)userPhone;
+ (void)setUserPhone:(id)userPhone;

+ (id)userCoins;
+ (void)setUserCoins:(id)userCoins;

+ (id)userLoginName;
+ (void)setUserLoginName:(id)userLoginName;

+ (id)userPassword;
+ (void)setUserPassword:(id)userPassword;

+ (id)txtLongtitude;
+ (void)setTxtLongtitude:(id)txtLongtitude;

+ (id)txtLatitude;
+ (void)setTxtLatitude:(id)txtLongtitude;

+ (id)keyWord;
+ (void)setKeyWord:(id)keyArr;

+ (id)keyWordAtt;
+ (void)setKeyWordAtt:(id)keyWordAtt;

+ (int)listVCIndex;
+ (void)setListVCIndex:(int)index;

+ (NSString*)uuid;
+ (void)setUuid:(NSString*)uuid;

@end
