////
////  WXUserService.m
////  ZGNCDSW
////
////  Created by 龙莲莲 on 16/4/28.
////  Copyright © 2016年 Macx. All rights reserved.
////
//
//#import "WXUserService.h"
//#import "PrefixHeader.pch"
//#import "WXUserModel.h"
//#define REGISTER_URL [NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,@""]
//#define LOGIN_URL [NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,@""]
//#define UPDATE_PASSWORD_URL [NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,@""]
//#define UPDATE_INFORMATION_URL [NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,@""]
//#define VERTIFY_USERNAME_URL [NSString stringWithFormat:@"%@%@",BASE_SERVICE_URL,@""]
//@implementation WXUserService
//+(id)sharedClient{
//    static dispatch_once_t pred;
//    static WXUserService *shared_instance=nil;
//    dispatch_once(&pred, ^{
//        shared_instance=[[self alloc] init];
//        shared_instance.client=[self sharedHTTPClient];
//    });
//    return shared_instance;
//}
//-(void)userRegistWithUserName:(NSString *)userName Password:(NSString *)password RegisterTime:(NSString *)registerTime Telephone:(NSString *)telephone Completion:(getUserRegistCompletionHandler)success Failure:(getUserRegistErrorHandler)failure{
//    
//    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithObjectsAndKeys:userName,@"UserName",password,@"Password",registerTime, @"Regist_time",telephone,@"Tel",nil];
//    [self.client postPath:REGISTER_URL parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
//        NSString *alertStr=nil;
//        if (operation.response.statusCode==200) {
//            alertStr=@"200";
//        }else{
//            alertStr=@"error";
//        }
//        success(alertStr);
//        
//    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        if (operation.response.statusCode==409) {
//            failure(@"409");
//        }
//        failure(@"error");
//    }];
//}
//-(void)userLoginWithUserName:(NSString *)userName Password:(NSString *)password Completion:(getUserLoginCompletionHandler)success Failure:(getUserLoginErrorHandler)failure{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userName,@"UserName",password,@"Password", nil];
//    
//    NSLog(@"this is parms=%@",params);
//    
//    [self.client getPath:LOGIN_URL parameters:params success:^(AFHTTPRequestOperation *operation ,id responseObjcet){
//        
//        id JSON=((AFJSONRequestOperation *)operation).responseJSON;
//        NSLog(@"this is JSON=%@",JSON);
//        
//        NSDictionary *dataDic=JSON;
//        
//        success([[[WXUserModel alloc] init]getUserDataWithDictionaryJSON:dataDic]) ;
//        
//    } failure:^(AFHTTPRequestOperation *operation , NSError *error){
//        
//        NSLog(@"错误为%ld",operation.response.statusCode);
//        failure(@"网络异常无法读取数据（登录）");
//    }];
//
//}
//-(void)updateUserPasswordWithUserID:(NSString *)userID UserName:(NSString *)userName ReSetPassword:(NSString *)password Completion:(updateUserPasswordCompletionHandler)success Failure:(updateUserPasswordErrorHandler)failure{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithObjectsAndKeys:userName,@"UserName",password,@"ReSetPassword",nil];
//    [self.client postPath:UPDATE_PASSWORD_URL parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
//        NSString *alertStr=nil;
//        if (operation.response.statusCode==200) {
//            alertStr=@"200";
//        }else{
//            alertStr=@"error";
//        }
//        success(alertStr);
//        
//    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        if (operation.response.statusCode==409) {
//            failure(@"409");
//        }
//        failure(@"error");
//    }];
//
//}
//-(void)updateUserInformationWithUserID:(NSString *)userID UserName:(NSString *)userName Telphone:(NSString *)tel User_image:(NSString *)image Now_Address:(NSString *)address Email:(NSString *)email Age:(NSString *)age Sex:(NSString *)sex Completion:(updateUserInformationCompletionHandler)success Failure:(updateUserInformationErrorHandler)failure{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc] initWithObjectsAndKeys:userName,@"UserName",tel,@"Tel",image, @"User_image",address,@"Now_Address",email,@"Email",age,@"Age",sex,@"Sex",nil];
//    [self.client postPath:UPDATE_INFORMATION_URL parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
//        id JSON=((AFJSONRequestOperation *)operation).responseJSON;
//        NSLog(@"this is JSON=%@",JSON);
//        
//        NSDictionary *dataDic=JSON;
//        
//        success([[[WXUserModel alloc] init]getUserDataWithDictionaryJSON:dataDic]) ;
//        
//    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        
//        NSLog(@"错误为%ld",operation.response.statusCode);
//        failure(@"网络异常无法读取数据");
//    }];
//}
//-(void)vertifyUserNameIsExitWithUserName:(NSString *)userName Completion:(vertifyUserNameIsExitCompletionHandler)success Failure:(vertifyUserNameIsExitErrorHandler)failure{
//    NSString *path=[NSString stringWithFormat:@"%@?UserName=%@",VERTIFY_USERNAME_URL,userName];
//    [self.client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
//        if (operation.response.statusCode==200) {
//            success(@"200");
//        }
//    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
//        
//    }];
//}
//@end
