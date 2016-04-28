//
//  WXTopView.h
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
@interface WXTopView : UIView
@property(nonatomic,strong)UIButton *backButton;
-(instancetype)initWithFrame:(CGRect)frame TitleText:(NSString *)title;

@end
