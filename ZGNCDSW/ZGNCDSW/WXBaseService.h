//
//  WXBaseService.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "SBJson.h"
@interface WXBaseService : NSObject
@property(strong,nonatomic)AFHTTPClient *client;
+(id)sharedHTTPClient;
+(id)sharedClient;
@end
