//
//  WXUserRegistViewController.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"

@interface WXUserRegistViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;

@property(nonatomic,strong)UIButton *clickNextBtn;
@property(nonatomic,strong)UILabel *alertLbl;
@property(nonatomic,strong)NetWork *isHaveNet;
@end
