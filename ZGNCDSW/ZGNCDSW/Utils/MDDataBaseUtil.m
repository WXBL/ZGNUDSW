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
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
}

+ (void)setUserID:(id)userID{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)userName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
}

+ (void)setUserName:(id)userName{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)password {
    return [[NSUserDefaults standardUserDefaults] objectForKey:PASSWORD];
}

+ (void)setPassword:(id)password{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (id)tel {
    return [[NSUserDefaults standardUserDefaults] objectForKey:TEL];
    
}

+ (void)setTel:(id)tel{
    [[NSUserDefaults standardUserDefaults] setObject:tel forKey:TEL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (id)age {
    return [[NSUserDefaults standardUserDefaults] objectForKey:AGE];
}

+ (void)setAge:(id)age{
    [[NSUserDefaults standardUserDefaults] setObject:age forKey:AGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)sex
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:SEX];
}

+ (void)setSex:(id)sex
{
    [[NSUserDefaults standardUserDefaults] setObject:sex forKey:SEX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (id)registTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:REGIST_TIME];
}

+ (void)setRegistTime:(id)registTime{
    [[NSUserDefaults standardUserDefaults] setObject:registTime forKey:REGIST_TIME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)lastLoginTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LAST_LOGIN_TIME];
}

+ (void)setLastLoginTime:(id)lastLoginTime
{
    [[NSUserDefaults standardUserDefaults] setObject:lastLoginTime forKey:LAST_LOGIN_TIME];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)userImage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE];
}

+ (void)setUserImage:(id)userImage
{
    [[NSUserDefaults standardUserDefaults] setObject:userImage forKey:USER_IMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (id)email
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:EMAIL];
}

+ (void)setEmail:(id)email
{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:EMAIL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)loginAddress{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_ADDRESS];
}
+ (void)setLoginAddress:(id)loginAddress{
    [[NSUserDefaults standardUserDefaults] setObject:loginAddress forKey:LOGIN_ADDRESS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (id)nowAddress{
    return [[NSUserDefaults standardUserDefaults] objectForKey:NOW_ADDRESS];
}
+ (void)setNowAddress:(id)nowAddress{
    [[NSUserDefaults standardUserDefaults] setObject:nowAddress forKey:NOW_ADDRESS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)note
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:NOTE];
    
}

+ (void)setNote:(id)note
{
    [[NSUserDefaults standardUserDefaults] setObject:note forKey:NOTE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)levelID{
    return [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:LEVEL_ID]];
}
+(void)setLevelID:(id)levelID{
    [[NSUserDefaults standardUserDefaults] setObject:levelID forKey:LEVEL_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(id)rankContent{
    return [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:RANK_CONTENT]];
}
+(void)setRankContent:(id)rankContent{
    [[NSUserDefaults standardUserDefaults] setObject:rankContent forKey:RANK_CONTENT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
