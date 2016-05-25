//
//  WXCommendTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/24.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCommendTableViewCell.h"

@implementation WXCommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)/2)];
        cellView.backgroundColor = [UIColor grayColor];
        [self addSubview:cellView];
        
        self.productImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetHeight(cellView.frame)-20, CGRectGetHeight(cellView.frame)-20)];
        [self.productImage.layer setCornerRadius:5];
        [cellView addSubview:self.productImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.productImage.frame)+10, self.productImage.frame.origin.y, cellView.frame.size.width/2, self.productImage.frame.size.height/2)];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [cellView addSubview:self.titleLabel];
        
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame), self.titleLabel.frame.origin.y, 80, 80)];
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        [cellView addSubview:self.priceLabel];
        
        self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.priceLabel.frame.origin.x, CGRectGetMaxX(self.priceLabel.frame), 80, 80)];
        self.numLabel.textColor = [UIColor blackColor];
        self.numLabel.textAlignment = NSTextAlignmentCenter;
        self.numLabel.font = [UIFont systemFontOfSize:14];
        [cellView addSubview:self.numLabel];
        
       
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
