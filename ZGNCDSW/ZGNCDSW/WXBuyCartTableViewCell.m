//
//  WXBuyCartTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXBuyCartTableViewCell.h"

@implementation WXBuyCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *cartBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
        cartBgView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self addSubview:cartBgView];
        
        self.productImage = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 100, 100)];
        [self.productImage.layer setCornerRadius:5];
//        [self.productImage setImage:[UIImage imageNamed:@"news_list1"]];
        [self addSubview:self.productImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 0, screenWidth - 180, 40)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 2;
        [self addSubview:self.titleLabel];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, CGRectGetMaxY(self.titleLabel.frame) , screenWidth - 230, 30)];
        self.priceLabel.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
        self.priceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.priceLabel];
        
        self.buyNum = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 50, CGRectGetMaxY(self.titleLabel.frame) , 50, 30)];
        self.buyNum.textColor = [UIColor blackColor];
        self.buyNum.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.buyNum];
        
        self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reduceButton.frame = CGRectMake(200, cartBgView.frame.size.height-50, 50, 50);
        [self.reduceButton setTitle:@"-" forState:UIControlStateNormal];
        [self.reduceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.reduceButton];
        
        self.buyNumLabel = [[UILabel alloc]init];
        self.buyNumLabel.frame = CGRectMake(CGRectGetMaxX(self.reduceButton.frame), cartBgView.frame.size.height-40, 100, 30);
        self.buyNumLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.buyNumLabel.textColor = [UIColor blackColor];
        self.buyNumLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.buyNumLabel];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.frame = CGRectMake(CGRectGetMaxX(self.buyNumLabel.frame), cartBgView.frame.size.height-50, 50, 50);
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.addButton];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
