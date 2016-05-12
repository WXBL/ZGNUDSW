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
//    UIView *statementView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth-60, screenWidth, 60)];
    self.backgroundColor = [UIColor whiteColor];
//    [self addSubview:statementView];
    self.frame = CGRectMake(0, screenHeigth - 60, screenWidth, 60);
    self.allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allButton.frame = CGRectMake(10, 15, 30,30);

    [self.allButton setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:(UIControlStateNormal)];
    [self.allButton addTarget:self action:@selector(ClickAllBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.allButton];

    
    UILabel *chooseAll = [[UILabel alloc]init];
    chooseAll.frame = CGRectMake(50, 0, 50,self.frame.size.height);
    chooseAll.text = @"全选";
    chooseAll.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    chooseAll.font = [UIFont systemFontOfSize:14];
    [self addSubview:chooseAll];
    self.chooseAll = chooseAll;
    
    UIButton *statement = [UIButton buttonWithType:UIButtonTypeCustom];
    statement.frame = CGRectMake(screenWidth*0.8, 0, screenWidth*0.2,  self.frame.size.height);
    statement.backgroundColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    [statement setTitle:@"结算" forState:UIControlStateNormal];
    [statement setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:statement];
    self.statement = statement;
    
    UILabel *totalled = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, 0, screenWidth*0.15 , self.frame.size.height/2)];
    totalled.text = @"总计：";
    totalled.textColor = [UIColor grayColor];
    totalled.font = [UIFont systemFontOfSize:14];
    [self addSubview:totalled];
    
    UILabel *totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*0.65, 0, screenWidth*0.15 , self.frame.size.height/2)];
//    totalPrice.text = @"$15.00";
    totalPrice.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
    totalPrice.font = [UIFont systemFontOfSize:14];
    [self addSubview:totalPrice];
    self.totalPrice = totalPrice;
    
    UILabel *luggage = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2, self.frame.size.height/2, screenWidth*0.3 , self.frame.size.height/2)];
    luggage.text = @"不含运费";
    luggage.textColor = [UIColor grayColor];
    luggage.font = [UIFont systemFontOfSize:14];
    [self addSubview:luggage];

}

-(void)ClickAllBtn:(UIButton *)button{
    NSLog(@"asdasdas");
    if ([self.delegate respondsToSelector:@selector(cartToolBar:didClickButton:)]) {
        [self.delegate cartToolBar:self didClickButton:button];
    }
}

//-(void)setModel:(WXShoppingCellModel *)model{
//    if (model.cellClickState == 1) {
//        
//        isbool = YES;
//        [self.allButton setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
//        
//    } else {
//        
//        isbool = NO;
//        [self.allButton setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
//    }
//}
//
//-(void)ClickAllButton:(UIButton *)sender{
//    if (isbool) {
//        _model.cellClickState = 0;
//        [self.allButton setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
//        isbool = NO;
//    }else{
//        _model.cellClickState = 1;
//        [self.allButton setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
//        isbool = YES;
//    }
//}

@end
