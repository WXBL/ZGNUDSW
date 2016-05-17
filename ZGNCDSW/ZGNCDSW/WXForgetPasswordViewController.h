//
//  WXForgetPasswordViewController.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "NetWork.h"
@interface WXForgetPasswordViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITextField *telePhoneTextField;
@property(nonatomic,strong)UILabel *signLbl;

@property(nonatomic,strong)UIButton *registerBtn;

@property(nonatomic,strong)UILabel *alertLbl;
@property(nonatomic,strong)NetWork *isHaveNet;
@property(nonatomic,strong)UITextField *passTextField;


@end
