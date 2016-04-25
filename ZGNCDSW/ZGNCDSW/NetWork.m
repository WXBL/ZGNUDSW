//
//  NetWork.m
//  IOS 7-登陆界面
//
//  Created by Apple－18 on 15/10/15.
//  Copyright (c) 2015年 Apple－18. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

-(BOOL)isHaveNetWork{
    
    //1.检测WiFi状态
    Reachability *wifi=[Reachability reachabilityForLocalWiFi];
    
    //2.检测手机是否能上网络（wifi/2G/3G）
    Reachability *conn=[Reachability reachabilityForInternetConnection];
    
    //3.判断网络状态
    if([wifi currentReachabilityStatus]!=NotReachable){
        
        //有wifi
        NSLog(@"使用wifi");
        return YES;
        
    }else if([conn currentReachabilityStatus]!=NotReachable){
        
        //没有使用wifi，使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        return YES;
        
    }else{
        
        NSLog(@"没有使用网络");
        return NO;
    }
}

@end
