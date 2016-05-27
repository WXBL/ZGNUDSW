//
//  WXHeaderView.h
//  ZGNCDSW
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXUserInforModel.h"
@protocol WXHeaderViewDelegate <NSObject>

- (void)headerView:(UIView *)headerView didClickButton:(UIButton *)button;

@end
@interface WXHeaderView : UIView

@property (nonatomic,strong)UIView *bgView;

@property (nonatomic,strong)UIButton *headerButton;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UIButton *loginButton;

@property (nonatomic,strong)id<WXHeaderViewDelegate>delegate;

@property (nonatomic,strong)WXUserInforModel *userInforModel;

@end
