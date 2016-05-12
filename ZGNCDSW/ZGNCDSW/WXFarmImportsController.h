//
//  WXFarmImportsController.h
//  ZGNCDSW
//
//  Created by admin on 16/4/25.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXTypeModel.h"
@interface WXFarmImportsController : UIViewController
@property(assign)int showType;
@property(nonatomic,strong)WXTypeModel *typeModel;
@property(nonatomic,strong)NSMutableArray *productArray;
@end
