//
//  WXStatusModel.h
//  ZGNCDSW
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUserModel.h"
@class WXUserModel;
@interface WXStatusModel : NSObject

//评论内容
@property (nonatomic,copy)NSString *Comment_Content;

@property (nonatomic,copy)NSString *Comment_Time;

@property (nonatomic,copy)WXUserModel *user;

/**	int	评论数*/
@property (nonatomic, assign) int comments_count;

@property (nonatomic,copy)NSString *category;


@end
