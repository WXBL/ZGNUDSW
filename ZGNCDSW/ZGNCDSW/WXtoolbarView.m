//
//  WXtoolbarView.m
//  ZGNCDSW
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXtoolbarView.h"

@interface WXtoolbarView ()



@end
@implementation WXtoolbarView

-(NSMutableArray *)btns{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

+(instancetype)toolbar{
    return [[self alloc]init];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //添加按钮
        [self addBtns];
    }
    return self;
}

-(void)addBtns{
    
    self.defaultBtn = [[UIButton alloc]init];
    CGFloat defaultBtnX = 10;
    CGFloat defaultBtnY = 5;
    CGFloat defaultBtnWH = 20;
    self.defaultBtn.frame = CGRectMake(defaultBtnX, defaultBtnY, defaultBtnWH, defaultBtnWH);
    [self.defaultBtn setImage:[UIImage imageNamed:@"unselected_btn"] forState:UIControlStateNormal];
    [self.defaultBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateFocused];
    [self.defaultBtn setImage:[UIImage imageNamed:@"selected_btn"] forState:UIControlStateSelected];
//    [self.defaultBtn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.defaultBtn];
//    self.defaultBtn.tag = self.theTag;
    
    self.setDefaultBtn = [[UIButton alloc]init];
    self.setDefaultBtn.frame = CGRectMake(CGRectGetMaxX(self.defaultBtn.frame)+5, 5, screenWidth/2-CGRectGetMaxX(self.defaultBtn.frame), 20);
    [self.setDefaultBtn setTitle:@"设置为默认地址" forState:UIControlStateNormal];
    [self.setDefaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.setDefaultBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.setDefaultBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
//    [self.setDefaultBtn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.setDefaultBtn];
    
    self.editBtn = [[UIButton alloc]init];
    CGFloat editBtnW = 60;
    CGFloat editBtnH = 20;
    self.editBtn.frame = CGRectMake(CGRectGetMaxX(self.setDefaultBtn.frame)+50, 5, editBtnW, editBtnH);
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.editBtn.layer setBorderWidth:1];
    [self.editBtn.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.editBtn.layer setCornerRadius:5];
    [self.editBtn.layer setMasksToBounds:YES];
    self.editBtn.tag = 200;
    [self.setDefaultBtn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.editBtn];
    
    self.deleteBtn = [[UIButton alloc]init];
    self.deleteBtn.frame = CGRectMake(CGRectGetMaxX(self.editBtn.frame)+20, 5, editBtnW, editBtnH);
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.deleteBtn.layer setBorderWidth:1];
    [self.deleteBtn.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.deleteBtn.layer setCornerRadius:5];
    [self.deleteBtn.layer setMasksToBounds:YES];
    self.deleteBtn.tag = 300;
    [self.setDefaultBtn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
}

-(void)ClickBtn:(UIButton *)button{
    NSLog(@"asdasdas");
    if ([self.delegate respondsToSelector:@selector(addressToolBar:didClickButton:)]) {
        [self.delegate addressToolBar:self didClickButton:button];
    }
}

@end
