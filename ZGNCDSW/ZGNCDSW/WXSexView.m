//
//  WXSexView.m
//  ZGNCDSW
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXSexView.h"

@implementation WXSexView


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
    
    UIView *sexView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    sexView.alpha = 0.5;
    sexView.backgroundColor = [UIColor grayColor];
    [self addSubview:sexView];
    self.sexView = sexView;
    
    UIButton *manButton = [UIButton buttonWithType:UIButtonTypeCustom];
    manButton.frame = CGRectMake(sexView.frame.size.width * 0.1, sexView.frame.size.height-200, sexView.frame.size.width *0.8, 40);
    [ manButton setBackgroundColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1]];
    [manButton setTitle:@"男" forState:UIControlStateNormal];
    [manButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    manButton.layer.cornerRadius = 10;
    manButton.tag = 101;
    [manButton addTarget:self action:@selector(ClickSexButton:) forControlEvents:UIControlEventTouchUpInside];
    self.manButton = manButton;
    
    UIButton *gileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gileButton.frame = CGRectMake(sexView.frame.size.width * 0.1, sexView.frame.size.height-130, sexView.frame.size.width *0.8, 40);
    [ gileButton setBackgroundColor:[UIColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:1]];
    [gileButton setTitle:@"女" forState:UIControlStateNormal];
    [gileButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    gileButton.layer.cornerRadius = 10;
    gileButton.tag = 102;
    [gileButton addTarget:self action:@selector(ClickSexButton:) forControlEvents:UIControlEventTouchUpInside];
    self.girlButton = gileButton;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(sexView.frame.size.width * 0.1, sexView.frame.size.height-60, sexView.frame.size.width *0.8, 40);
    [ cancelButton setBackgroundColor:[UIColor grayColor]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.layer.cornerRadius = 10;
    cancelButton.tag = 103;
    [cancelButton addTarget:self action:@selector(ClickSexButton:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton = cancelButton;
    [self addSubview:manButton];
    [self addSubview:gileButton];
    [self addSubview:cancelButton];
}

-(void)ClickSexButton:(UIButton *)button{
    NSLog(@"asdasdas");
    if ([self.delegate respondsToSelector:@selector(WXSexView:didClickButton:)]) {
        [self.delegate WXSexView:self didClickButton:button];
    }
}
@end
