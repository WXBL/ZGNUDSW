//
//  WXUserInforModel.m
//  ZGNCDSW
//
//  Created by admin on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXUserInforModel.h"

@implementation WXUserInforModel



-(void)setMbtype:(NSString *)mbtype
{
    _mbtype = mbtype;
    
    self.vip = _mbrank > 2;
}
@end
