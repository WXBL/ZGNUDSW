//
//  WXTopView.m
//  ZGNCDSW
//
//  Created by Macx on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXTopView.h"

@implementation WXTopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame TitleText:(NSString *)title{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:0.5 green:0.7 blue:0.4 alpha:1];
//        self.backgroundColor=[UIColor colorWithWhite:1 alpha:0.7];
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backButton.frame = CGRectMake(5, 10, 80, 40);
        self.backButton.tag=100;
        [self.backButton setTitle:@"返回" forState:UIControlStateNormal];
        [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:self.backButton];
        CGFloat width=self.frame.size.width *0.4;
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake((screenWidth-width)/2, 10, width, 40)];
        titleLbl.text = title;
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.font = [UIFont systemFontOfSize:20];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLbl];
    }
    return self;
}

@end
