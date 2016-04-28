//
//  WXNewsTableCell.m
//  ZGNCDSW
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXNewsTableCell.h"

@implementation WXNewsTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *newView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, screenWidth - 20, 160)];
        newView.backgroundColor = [UIColor whiteColor];
        [self addSubview:newView];
    }
    
    return self;
}
@end
