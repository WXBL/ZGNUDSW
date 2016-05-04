//
//  WXfarmImportsTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/4/29.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXfarmImportsTableViewCell.h"

@implementation WXfarmImportsTableViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.farmImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-60)];
        self.farmImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.farmImage.layer setCornerRadius:5];
        [self addSubview:self.farmImage];
        [self.layer setCornerRadius:5];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.farmImage.frame.size.height +5 , self.frame.size.width, 30)];
        self.titleLabel.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.2 alpha:1];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.titleLabel];
        
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2, self.farmImage.frame.size.height +30, self.frame.size.width / 2 -10, 30)];
        self.priceLabel.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.2 alpha:1];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.priceLabel];
        
        self.saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.farmImage.frame.size.height +30, self.frame.size.width / 2 /2, 30)];
        self.saleLabel.text = @"销量";
        self.saleLabel.textColor = [UIColor grayColor];
        self.saleLabel.textAlignment = NSTextAlignmentLeft;
        self.saleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.saleLabel];
        
        self.saleNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width / 2 /2, self.farmImage.frame.size.height +30, self.frame.size.width / 2/2 , 30)];
        self.saleNumLabel.textColor = [UIColor grayColor];
        self.saleNumLabel.textAlignment = NSTextAlignmentLeft;
        self.saleNumLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.saleNumLabel];
        
    }
    
    return self;
}

@end
