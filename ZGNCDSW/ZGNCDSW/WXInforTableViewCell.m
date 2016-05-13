//
//  WXInforTableViewCell.m
//  SCGoJD
//
//  Created by Macx on 16/4/7.
//  Copyright © 2016年 WX. All rights reserved.
//

#import "WXInforTableViewCell.h"

@implementation WXInforTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textlbl=[[UILabel alloc]initWithFrame:CGRectMake( screenWidth* 0.5, 0, screenWidth * 0.4, CGRectGetHeight(self.frame))];
        self.textlbl.textAlignment = NSTextAlignmentRight;
        self.textlbl.font = [UIFont systemFontOfSize:14];
        self.textlbl.textColor = [UIColor grayColor];
        
        //        [self.textlbl sizeToFit];
        [self addSubview:self.textlbl];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
