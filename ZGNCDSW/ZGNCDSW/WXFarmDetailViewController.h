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
@interface WXFarmDetailViewController : UIViewController
@property(nonatomic,strong)WXProductModel *theProduct;
@property(nonatomic,strong)NSMutableArray *productImgArr;//存放图片数据
@property(nonatomic,strong)WXShoppingCarModel *shoppingCarModel;
@end
