//
//  WXReturnrefundTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXReturnrefundTableViewCell.h"

@implementation WXReturnrefundTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
        cellView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cellView];
        
        self.prodctImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
        [self.prodctImage setBackgroundColor:[UIColor redColor]];
        [cellView addSubview:self.prodctImage];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
