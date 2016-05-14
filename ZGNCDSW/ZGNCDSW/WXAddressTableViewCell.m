//
//  WXAddressTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddressTableViewCell.h"

@implementation WXAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, CGRectGetHeight(self.frame)-10)];
        cellView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cellView];
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame)/2-10, CGRectGetHeight(self.frame)/3)];
        name.text = @"jwh";
        name.textColor = [UIColor blackColor];
        name.font = [UIFont systemFontOfSize:14];
        name.textAlignment = NSTextAlignmentLeft;
        [cellView addSubview:name];
    }
    return self;
}


//+ (instancetype)cellWithTableView:(UITableView *)tableView
//{
//    
//}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.backgroundColor = [UIColor clearColor];
//        
//        //点击cell时不变色
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        NSLog(@"%f",CGRectGetHeight(self.frame));
//        //初始化评论信息
//        
//    }
//    return self;
//}
-(void)showAddressInfor{
   
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
