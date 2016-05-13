////
////  WXBaseService.m
////  ZGNCDSW
////
////  Created by 龙莲莲 on 16/4/28.
////  Copyright © 2016年 Macx. All rights reserved.
////
//
//#import "WXBaseService.h"
//#import "PrefixHeader.pch"
//
//@implementation WXBaseService
//+(id)sharedHTTPClient{
//    AFHTTPClient *shared_instance;
//    shared_instance=[AFHTTPClient clientWithBaseURL:[NSURL URLWithString:BASE_SERVICE_URL]];
//    [shared_instance registerHTTPOperationClass:[AFJSONRequestOperation class]];
//    [shared_instance setDefaultHeader:@"Accept" value:@"application/json"];
//    shared_instance.parameterEncoding=AFJSONParameterEncoding;
//    return shared_instance;
//}
//
//+(id)sharedClient{
//    static dispatch_once_t pred;
//    static WXBaseService *shared_instance=nil;
//    dispatch_once(&pred, ^{
//        shared_instance=[[self alloc] init];
//        shared_instance.client=[self sharedHTTPClient];
//    });
//    return shared_instance;
//}
//@end
