//
//  WXShoppingModel.h
//  ZGNCDSW
//
//  Created by admin on 16/5/9.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXShoppingModel : NSObject

@property (nonatomic, copy) NSDictionary *headPriceDict;

//头部 id
@property (nonatomic, copy) NSString *headID;

//头部 状态
@property (nonatomic, assign) NSInteger headState;

//头部 选中状态
@property (nonatomic, assign) NSInteger headClickState;

//分组数据
@property (nonatomic, copy) NSMutableArray *headCellArray;



-(instancetype)initWithShopDict:(NSDictionary *)dict;
@end


@interface WXShoppingCellModel : NSObject

@property (nonatomic, copy) NSDictionary *cellPriceDict;

//编辑状态
@property (nonatomic, assign) NSInteger cellEditState;

//图片
@property (nonatomic, copy) NSString *imageUrl;

//标题
@property (nonatomic, copy) NSString *title;

//颜色
@property (nonatomic, copy) NSString *color;

//尺码
@property (nonatomic, copy) NSString *size;

//价格
@property (nonatomic, copy) NSString *price;

//数量
@property (nonatomic, assign) NSInteger numInt;

//库存
//@property (nonatomic, assign) NSInteger inventoryInt;

//必选
@property (nonatomic, assign) NSInteger mustInteger;

//ID
@property (nonatomic, copy)  NSString *ID;

//折扣
//@property (nonatomic, copy) NSString *discountNum;

//cell 选中状态
@property (nonatomic, assign) NSInteger cellClickState;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, assign) NSInteger indexState;

-(instancetype)initWithShopDict:(NSDictionary *)dict;


@end