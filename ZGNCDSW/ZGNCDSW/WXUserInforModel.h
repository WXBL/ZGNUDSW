//
//  WXUserInforModel.h
//  ZGNCDSW
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUserModel.h"
@class WXUserModel;
@interface WXUserInforModel : NSObject

//用户信息，详细
@property (nonatomic,strong)WXUserModel *user;

@property (nonatomic,copy)NSString *address;

@property (nonatomic,copy)NSString *member_procuctNum;
@property (nonatomic,copy)NSString *menber_shopNum;
@property (nonatomic,copy)NSString *member_scannedNum;//浏览记录数

@property (nonatomic,copy)NSString *balance;//余额
@property (nonatomic,copy)NSString *coupon;//优惠券
@property (nonatomic,copy)NSString *gold_coin;//金币



//会员类型
@property (nonatomic,copy) NSString *mbtype;
//会员等级
@property (nonatomic,assign) int mbrank;
@property (nonatomic,assign,getter=isVip)BOOL vip;
@end
