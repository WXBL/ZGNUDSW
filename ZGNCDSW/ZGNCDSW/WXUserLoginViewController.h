//
//  WXUserLoginViewController.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
@interface WXUserLoginViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *forgetPasswordBtn;
@property(nonatomic,strong)UIButton *registBtn;

@property(nonatomic,strong)UILabel *alertLbl;
@property(nonatomic,strong)NetWork *isHaveNet;

@end
