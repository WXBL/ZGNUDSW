//
//  WXCartTool.m
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCartTool.h"

@interface WXCartTool ()

@property (nonatomic,strong)UIButton *chooseAll;//全选
@property (nonatomic,strong)UIButton *statement;//结算
@property (nonatomic,strong)UILabel *totalPrice;//合计

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

-(void)setCellItems:(NSMutableArray *)cellItems
{
    _cellItems = cellItems;
    
    //设置全选状态，初始化状态就是全选
    self.chooseAll.selected = YES;
    for (NSString *selection in cellItems) {
        if ([selection isEqualToString:@"NO"]) {
            self.chooseAll.selected = NO;
        }
    }
    
    //设置总价
    
}

- (void)addSubviews{
    UIView *statementView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth-60, screenWidth, 60)];
    statementView.backgroundColor = [UIColor whiteColor];
    [self addSubview:statementView];
    
    UIButton *chooseAll = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseAll.frame = CGRectMake(50, 0, 50, statementView.frame.size.height);
    [chooseAll setTitle:@"全选" forState:UIControlStateNormal];
    [chooseAll setTitleColor:[UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1] forState:UIControlStateNormal];
    [statementView addSubview:chooseAll];
    
    UIButton *statement = [UIButton buttonWithType:UIButtonTypeCustom];
    statement.frame = CGRectMake(screenWidth*0.8, 0, screenWidth*0.2,  statementView.frame.size.height);
    statement.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    [statement setTitle:@"结算" forState:UIControlStateNormal];
    [statement setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [statementView addSubview:statement];
    
    UILabel *totalled = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, 0, screenWidth*0.15 , statementView.frame.size.height/2)];
    totalled.text = @"总计：";
    totalled.textColor = [UIColor grayColor];
    totalled.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:totalled];
    
    UILabel *totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*0.65, 0, screenWidth*0.15 , statementView.frame.size.height/2)];
    totalPrice.text = @"$15.00";
    totalPrice.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    totalPrice.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:totalPrice];
    
    UILabel *luggage = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, statementView.frame.size.height/2, screenWidth*0.3 , statementView.frame.size.height/2)];
    luggage.text = @"不含运费";
    luggage.textColor = [UIColor grayColor];
    luggage.font = [UIFont systemFontOfSize:14];
    [statementView addSubview:luggage];

}

@end
