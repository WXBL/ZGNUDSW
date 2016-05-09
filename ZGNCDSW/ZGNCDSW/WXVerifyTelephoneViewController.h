//
//  WXVerifyTelephoneViewController.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "NetWork.h"
@interface WXVerifyTelephoneViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,MFMessageComposeViewControllerDelegate>
@property(nonatomic,strong)UITextField *telePhoneTextField;
@property(nonatomic,strong)UITextField *verifyCodeTextField;
@property(nonatomic,strong)UIButton *getVerifyCodeBtn;
@property(nonatomic,strong)UILabel *signLbl;

@property(nonatomic,strong)UIButton *registerBtn;

@property(nonatomic,strong)UILabel *alertLbl;
@property(nonatomic,strong)NetWork *isHaveNet;

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *password;

@end
