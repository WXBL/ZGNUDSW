//
//  WXGZProductTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/19.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXGZProductTableViewCell.h"

#define ProductImageSize 100
#define CellBorderW 10
@implementation WXGZProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, CGRectGetHeight(self.frame)-10)];
        cellView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cellView];
        
        UIImageView *proImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, ProductImageSize, ProductImageSize)];
        [proImage.layer setCornerRadius:5];
        [cellView addSubview:proImage];
        self.proImage = proImage;
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.proImage.frame)+CellBorderW, self.proImage.frame.origin.y, screenWidth -self.proImage.frame.size.width-CellBorderW*2, self.proImage.frame.size.height/2)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [cellView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x, CGRectGetMaxY(self.titleLabel.frame), 100, self.proImage.frame.size.height/2)];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:14];
        [cellView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.frame = CGRectMake(screenWidth-100, CGRectGetMaxY(self.titleLabel.frame)+10, 80, 25);
        [cancle setTitle:@"取消关注" forState:UIControlStateNormal];
        [cancle setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [cancle.layer setBorderWidth:1];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:5];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14];
        [cellView addSubview:cancle];
        self.cancleConcern = cancle;
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
