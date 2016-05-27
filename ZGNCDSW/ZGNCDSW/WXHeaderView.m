//
//  WXHeaderView.m
//  ZGNCDSW
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXHeaderView.h"
#import "MDDataBaseUtil.h"
@implementation WXHeaderView

#pragma mark -初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

-(void)addSubviews{
    
    self.frame = CGRectMake(0, 0, screenWidth, 100);
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.bgView = self;
    
    
    
    UIButton *headButton = [[UIButton alloc]init];
    headButton.frame = CGRectMake(10, 10, CGRectGetHeight(self.bgView.frame)-20, CGRectGetHeight(self.bgView.frame)-20);
    [headButton.layer setCornerRadius:(CGRectGetHeight(self.bgView.frame)-20)/2];
    headButton.layer.masksToBounds=YES;
    [MDDataBaseUtil setUserName:@"asd"];
    
    headButton.tag = 0;
    [self.bgView addSubview:headButton];
    self.headerButton = headButton;
    
    self.userName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headerButton.frame)+10, self.headerButton.frame.origin.x, self.bgView.frame.size.width/2, self.headerButton.frame.size.height)];
    self.userName.textColor = [UIColor blackColor];
    self.userName.textAlignment = NSTextAlignmentLeft;
    self.userName.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.userName];
    
    if ([MDDataBaseUtil userName] == NULL) {
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginButton.frame = CGRectMake(CGRectGetMaxX(self.userName.frame), 30, 70, 35);
        [self.loginButton.layer setCornerRadius:5];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        self.loginButton.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        self.loginButton.tag = 1;
        [self.loginButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:self.loginButton];
        
        [self.headerButton setImage:[UIImage imageNamed:@"my_head_default"] forState:UIControlStateNormal];
        self.userName.text = @"用户登录";
        
    }else{
        [self.headerButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
        self.userName.text = [MDDataBaseUtil userName];
        
    }
    

}



-(void)ClickButton:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(headerView:didClickButton:)]) {
        [_delegate headerView:self didClickButton:button];
    }
}

@end
