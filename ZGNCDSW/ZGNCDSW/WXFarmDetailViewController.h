//
//  WXFarmDetailViewController.h
//  ZGNCDSW
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXProductModel.h"
#import "WXShoppingCarModel.h"
#import "ChoseView.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
@interface WXFarmDetailViewController : UIViewController<TypeSeleteDelegete>
@property(nonatomic,strong)WXProductModel *theProduct;
@property(nonatomic,strong)NSMutableArray *productImgArr;//存放图片数据
@property(nonatomic,strong)WXShoppingCarModel *shoppingCarModel;

//购买选项
@property(nonatomic,strong)ChoseView *choseView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,assign)CGPoint center;
@property(nonatomic,strong)NSMutableArray *sizeArr;
@property(nonatomic,strong)NSMutableArray *colorArr;
@property(nonatomic,strong)NSMutableDictionary *storeDic;

@property(nonatomic,strong)AFHTTPRequestOperationManager *AFOMG;
@property(nonatomic,strong)NSMutableArray *GoodsColorNumberArr;
@property(nonatomic,strong)NSMutableArray *GoodsSizeNumberArr;
@property(nonatomic,strong)NSMutableArray *ProductFeatureDataArr;

@end
