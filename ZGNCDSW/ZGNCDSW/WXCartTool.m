//
//  WXCartTool.m
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCartTool.h"

@interface WXCartTool ()

{
    BOOL isbool;
}

@end

@implementation WXCartTool



#pragma mark -初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}



- (void)addSubviews{
    UIView *statementView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth-60, screenWidth, 60)];
    statementView.backgroundColor = [UIColor whiteColor];
    [self addSubview:statementView];
    
    self.chooseAllImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 30, 30)];

    
    [statementView addSubview:self.chooseAllImage];
    
    UILabel *chooseAll = [[UILabel alloc]init];
    chooseAll.frame = CGRectMake(50, 0, 50, statementView.frame.size.height);
    chooseAll.text = @"全选";
    chooseAll.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    chooseAll.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:chooseAll];
    self.chooseAll = chooseAll;
    
    UIButton *statement = [UIButton buttonWithType:UIButtonTypeCustom];
    statement.frame = CGRectMake(screenWidth*0.8, 0, screenWidth*0.2,  statementView.frame.size.height);
    statement.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    [statement setTitle:@"结算" forState:UIControlStateNormal];
    [statement setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [statementView addSubview:statement];
    self.statement = statement;
    
    UILabel *totalled = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, 0, screenWidth*0.15 , statementView.frame.size.height/2)];
    totalled.text = @"总计：";
    totalled.textColor = [UIColor grayColor];
    totalled.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:totalled];
    
    UILabel *totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*0.65, 0, screenWidth*0.15 , statementView.frame.size.height/2)];
//    totalPrice.text = @"$15.00";
    totalPrice.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    totalPrice.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:totalPrice];
    self.totalPrice = totalPrice;
    
    UILabel *luggage = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, statementView.frame.size.height/2, screenWidth*0.3 , statementView.frame.size.height/2)];
    luggage.text = @"不含运费";
    luggage.textColor = [UIColor grayColor];
    luggage.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:luggage];

}

@end
