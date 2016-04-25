//
//  MDDataBaseUtil.m
//  Hbsj
//
//  Created by 小小世界 on 14-10-26.
//  Copyright (c) 2014年 mSquare. All rights reserved.
//

#import "MDDataBaseUtil.h"

@implementation MDDataBaseUtil

//checkIsLogin
+ (NSString *) isLogin {
    return [[NSUserDefaults standardUserDefaults] objectForKey:IS_LOGIN];
}

+ (void)setIsLogin:(NSString *) isLogin {
    [[NSUserDefaults standardUserDefaults] setObject:isLogin forKey:IS_LOGIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)userObject
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_OBJECT];
}

+ (void)setUserObject:(id)UserObject
{
    
    [[NSUserDefaults standardUserDefaults] setObject:UserObject forKey:M_USER_OBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
   
}
+ (id)userID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_ID];
}

+ (void)setUserID:(id)userID{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:M_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)userType
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_TYPE];
}

+ (void)setUserType:(id)userType{
    [[NSUserDefaults standardUserDefaults] setObject:userType forKey:M_USER_TYPE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)userUIN {
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_UIN];
}

+ (void)setUserUIN:(id)userUIN{
    [[NSUserDefaults standardUserDefaults] setObject:userUIN forKey:M_USER_UIN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (id)userCoins {
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_COINS];
    
}

+ (void)setUserCoins:(id)userCoins{
    [[NSUserDefaults standardUserDefaults] setObject:userCoins forKey:M_USER_COINS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (id)userLoginName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_LGOGIN_NAME];
}

+ (void)setUserLoginName:(id)userLoginName{
    [[NSUserDefaults standardUserDefaults] setObject:userLoginName forKey:M_USER_LGOGIN_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)userPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_PASSWORD];
}

+ (void)setUserPassword:(id)userPassword
{
    [[NSUserDefaults standardUserDefaults] setObject:userPassword forKey:M_USER_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (id)userPhone {
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_USER_PHONE];
}

+ (void)setUserPhone:(id)userPhone {
    [[NSUserDefaults standardUserDefaults] setObject:userPhone forKey:M_USER_PHONE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)txtLongtitude
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_LONGTITUDE];
}

+ (void)setTxtLongtitude:(id)txtLongtitude
{
    [[NSUserDefaults standardUserDefaults] setObject:txtLongtitude forKey:M_LONGTITUDE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)txtLatitude
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_LATITUDE];
}

+ (void)setTxtLatitude:(id)txtLongtitude
{
    [[NSUserDefaults standardUserDefaults] setObject:txtLongtitude forKey:M_LATITUDE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (id)keyWord
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_LIST_KEYWORD];
}

+ (void)setKeyWord:(id)keyArr
{
    [[NSUserDefaults standardUserDefaults] setObject:keyArr forKey:M_LIST_KEYWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)keyWordAtt{
    return [[NSUserDefaults standardUserDefaults] objectForKey:M_LIST_KEYWORD_ATT];
}
+ (void)setKeyWordAtt:(id)keyWordAtt{
    [[NSUserDefaults standardUserDefaults] setObject:keyWordAtt forKey:M_LIST_KEYWORD_ATT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (int)listVCIndex{
    NSNumber * number = [[NSUserDefaults standardUserDefaults] objectForKey:M_LIST_VC_INDEX];
    int index = [number intValue];
    return index;
}
+ (void)setListVCIndex:(int)index{
    NSNumber * indexNunmber = [NSNumber numberWithInt:index];
    [[NSUserDefaults standardUserDefaults] setObject:indexNunmber forKey:M_LIST_VC_INDEX];
}

+ (NSString *)uuid
{
    NSString *uuid = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:M_UUID]];
    return uuid;
}

+ (void)setUuid:(NSString*)uuid
{
    [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:M_UUID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
