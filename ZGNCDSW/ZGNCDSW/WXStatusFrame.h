//
//  WXStatusFrame.h
//  ZGNCDSW
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WXStatusModel.h"
#import "WXUserModel.h"

#define StatusCellBorderW 10

// 昵称字体
#define StatusCellNameFont [UIFont systemFontOfSize:15]

// 时间字体
#define StatusCellTimeFont [UIFont systemFontOfSize:12]

// 正文字体
#define StatusCellContentFont [UIFont systemFontOfSize:14]

//cell之间的间距
#define StatusCellMargin 15
@class WXStatusModel;
@interface WXStatusFrame : NSObject
/** 评论整体*/
@property (nonatomic, assign) CGRect commentViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/**  评论内容*/
@property (nonatomic, assign) CGRect commentContentF;
/** 时间 */
@property (nonatomic, assign) CGRect commentTimeF;
/** 类别*/
@property (nonatomic, assign) CGRect categoryF;

@property (nonatomic,assign)CGFloat cellHeight;

@property (nonatomic,strong)WXStatusModel *status;
@end
