//
//  WXHeaderView.m
//  ZGNCDSW
//
//  Created by admin on 16/5/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXHeaderView.h"

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
    self.frame = CGRectMake(0, 0, screenWidth, 200);
    self.backgroundColor = [UIColor colorWithRed:0.7 green:0.3 blue:0.5 alpha:1];
    
    self.bgView = self;
    
    //    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    
    UIButton *headButton = [[UIButton alloc]init];
    headButton.frame = CGRectMake(20, 20, 80, 80);
    [headButton.layer setCornerRadius:40];
    headButton.layer.masksToBounds=YES;
//    [headButton setImage:[UIImage imageNamed:@"my_head_default"] forState:UIControlStateNormal];
    [headButton addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    headButton.tag = 0;
    [self addSubview:headButton];
    
    self.headerButton = headButton;
    
    //用户匿名
    WXUserInforModel *userInforModel = [[WXUserInforModel alloc]init];
    UILabel *username = [[UILabel alloc]init];
    username.frame = CGRectMake(CGRectGetMaxX(self.headerButton.frame)+10, self.headerButton.frame.origin.y+10, screenWidth *0.5, 30);
//    username.text = userInforModel.user.UserName;
    username.text = @"降降jwh";
    username.textColor = [UIColor whiteColor];
    username.font = [UIFont systemFontOfSize:16];
    username.textAlignment = NSTextAlignmentLeft;
    [self addSubview:username];
    self.userName = username;
    
    //会员
    UILabel *member = [[UILabel alloc]initWithFrame:CGRectMake(self.userName.frame.origin.x, CGRectGetMaxY(self.userName.frame), screenWidth *0.5, 30)];

//    member.text = userInforModel.mbtype;
    member.text = @"钻石会员";
     member.textColor = [UIColor whiteColor];
    member.font = [UIFont systemFontOfSize:14];
    member.textAlignment = NSTextAlignmentLeft;
    [self addSubview:member];
    
    
    //账户管理，收货地址
    [self addAddress];
    //添加关注商品，店铺，浏览记录按钮
    [self conCernButton];

}

//账户管理，收货地址
-(void)addAddress{
    UIButton *management = [UIButton buttonWithType:UIButtonTypeCustom];
    management.frame = CGRectMake(self.bgView.frame.size.width /2, self.bgView.frame.size.height/2, self.bgView.frame.size.width /2, 30);
    [management setTitle:@"账户管理、收货地址 >" forState:UIControlStateNormal];
    [management setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    management.titleLabel.font = [UIFont systemFontOfSize:14];
    management.titleLabel.textAlignment = NSTextAlignmentRight;
    management.tag = 4;
    [management addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:management];
}

-(void)conCernButton{
//    WXUserInforModel *userInforModel = [[WXUserInforModel alloc]init];
    
    UIButton *product = [UIButton buttonWithType:UIButtonTypeCustom];
    product.frame = CGRectMake(0, self.bgView.frame.size.height-60, (self.bgView.frame.size.width-4)/3, 60);
    product.backgroundColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.4 alpha:1];
    [product addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    product.tag =1;
    [self.bgView addSubview:product];
    
    UILabel *productNum = [[UILabel alloc]init];
    productNum.frame = CGRectMake(0, 0, product.frame.size.width, product.frame.size.height/2);
//    productNum.text = userInforModel.member_procuctNum;
    productNum.text = @"0";
    productNum.textColor = [UIColor whiteColor];
    productNum.font = [UIFont systemFontOfSize:16];
    productNum.textAlignment = NSTextAlignmentCenter;
    [product addSubview:productNum];
    
    UILabel *productLabel = [[UILabel alloc]init];
    productLabel.frame = CGRectMake(0, product.frame.size.height/2, product.frame.size.width, product.frame.size.height/2-5);
    productLabel.text = @"关注的产品";
    productLabel.textColor = [UIColor whiteColor];
    productLabel.font = [UIFont systemFontOfSize:15];
    productLabel.textAlignment = NSTextAlignmentCenter;
    [product addSubview:productLabel];
    
    UIButton *shop = [UIButton buttonWithType:UIButtonTypeCustom];
    shop.frame = CGRectMake((self.bgView.frame.size.width-4)/3+2, self.bgView.frame.size.height-60, (self.bgView.frame.size.width-4)/3, 60);
    shop.backgroundColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.4 alpha:1];
    [shop addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    shop.tag =2;
    [self.bgView addSubview:shop];
    
    UILabel *shopNum = [[UILabel alloc]init];
    shopNum.frame = CGRectMake(0, 0, product.frame.size.width, shop.frame.size.height/2);
    //    shopNum.text = userInforModel.member_shopNum;
    shopNum.text = @"10";
    shopNum.textColor = [UIColor whiteColor];
    shopNum.font = [UIFont systemFontOfSize:16];
    shopNum.textAlignment = NSTextAlignmentCenter;
    [shop addSubview:shopNum];
    
    UILabel *shopLabel = [[UILabel alloc]init];
    shopLabel.frame = CGRectMake(0, shop.frame.size.height/2, shop.frame.size.width, shop.frame.size.height/2-5);
    shopLabel.text = @"关注的店铺";
    shopLabel.textColor = [UIColor whiteColor];
    shopLabel.font = [UIFont systemFontOfSize:15];
    shopLabel.textAlignment = NSTextAlignmentCenter;
    [shop addSubview:shopLabel];

    
    UIButton *scanned = [UIButton buttonWithType:UIButtonTypeCustom];
    scanned.frame = CGRectMake(CGRectGetMaxX(shop.frame)+2, self.bgView.frame.size.height-60, (self.bgView.frame.size.width-4)/3, 60);
    scanned.backgroundColor = [UIColor colorWithRed:0.5 green:0.2 blue:0.4 alpha:1];
    [scanned addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
    scanned.tag =3;
    [self.bgView addSubview:scanned];
    
    UILabel *scannedNum = [[UILabel alloc]init];
    scannedNum.frame = CGRectMake(0, 0, product.frame.size.width, product.frame.size.height/2);
    //    scannedNum.text = userInforModel.member_scannedNum;
    scannedNum.text = @"120";
    scannedNum.textColor = [UIColor whiteColor];
    scannedNum.font = [UIFont systemFontOfSize:16];
    scannedNum.textAlignment = NSTextAlignmentCenter;
    [scanned addSubview:scannedNum];
    
    UILabel *scannedLabel = [[UILabel alloc]init];
    scannedLabel.frame = CGRectMake(0, scanned.frame.size.height/2, scanned.frame.size.width, scanned.frame.size.height/2-5);
    scannedLabel.text = @"浏览的纪录";
    scannedLabel.textColor = [UIColor whiteColor];
    scannedLabel.font = [UIFont systemFontOfSize:15];
    scannedLabel.textAlignment = NSTextAlignmentCenter;
    [scanned addSubview:scannedLabel];

}

-(void)ClickButton:(UIButton *)button{
    if ([_delegate respondsToSelector:@selector(headerView:didClickButton:)]) {
        [_delegate headerView:self didClickButton:button];
    }
}

@end
