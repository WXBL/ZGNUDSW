//
//  WXResetPasswordViewController.h
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
@interface WXResetPasswordViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITextField *originPasswordText;
@property(nonatomic,strong)UITextField *resetPasswordText;
@property(nonatomic,strong)UIButton *resetPasswordBtn;
@property(nonatomic,strong)UILabel *alertLbl;
@property(nonatomic,strong)NetWork *isHaveNet;
@end
