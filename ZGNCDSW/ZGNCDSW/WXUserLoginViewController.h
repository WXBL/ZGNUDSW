//
//  WXUserLoginViewController.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXUserLoginViewController : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *userNameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;

@end
