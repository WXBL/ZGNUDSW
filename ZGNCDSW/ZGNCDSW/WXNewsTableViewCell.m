//
//  WXNewsTableViewCell.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewsTableViewCell.h"

@implementation WXNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.newsImage=[[UIImageView alloc] initWithFrame:CGRectMake(2, 2, CGRectGetWidth(self.frame)-4, CGRectGetWidth(self.frame)-4)];
        [self addSubview:self.newsImage];
        self.newsTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.newsImage.frame)+4, 4, CGRectGetWidth(self.frame)-CGRectGetMaxX(self.newsImage.frame)-4, 40)];
        self.newsTitleLabel.textColor=[UIColor grayColor];
        self.newsTitleLabel.font=[UIFont fontWithName:nil size:14];
        [self addSubview:self.newsTitleLabel];
        self.newsDetailLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.newsTitleLabel.frame), CGRectGetMaxY(self.newsTitleLabel.frame)+4, CGRectGetWidth(self.newsTitleLabel.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(self.newsTitleLabel.frame))];
        [self addSubview:self.newsDetailLabel];
    }
    return self;
}
@end
