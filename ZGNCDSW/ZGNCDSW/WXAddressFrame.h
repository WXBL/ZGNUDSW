//
//  WXAddressFrame.h
//  ZGNCDSW
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define AddressCellBorderW 10

//收件人
#define AddressCellNameFont [UIFont systemFontOfSize:14]

#define AddressCellPhoneFont [UIFont systemFontOfSize:14]

#define AddressCellAddDetailFont [UIFont systemFontOfSize:13]

@class WXAddressModel;
@interface WXAddressFrame : NSObject



@property (nonatomic,strong)WXAddressModel *address;

@property (nonatomic,assign)CGRect cellViewF;

@property (nonatomic,assign)CGRect usernameF;
@property (nonatomic,assign)CGRect phoneF;
@property (nonatomic,assign)CGRect addressDetailF;
//底部工具条
@property (nonatomic,assign)CGRect toolBarF;

@property (nonatomic,assign)CGFloat cellHeight;

@end
