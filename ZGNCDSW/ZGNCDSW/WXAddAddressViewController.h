//
//  WXAddAddressViewController.h
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXAddressModel.h"

@protocol WXAddAddressViewControllerDelegate <NSObject>

@optional
-(void)addressViewController:(UIViewController *)addressViewController didClickButton:(UIButton *)button;

@end
@interface WXAddAddressViewController : UIViewController

@property (nonatomic,strong)id<WXAddAddressViewControllerDelegate>delegate;

@property (nonatomic,strong)WXAddressModel *addressModel;


@property (nonatomic,strong)UITextField *nameText;
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UILabel *areaText;
@property (nonatomic,strong)UITextField *PostcodesText;
@property (nonatomic,strong)UITextField *addressDetail;

@end
