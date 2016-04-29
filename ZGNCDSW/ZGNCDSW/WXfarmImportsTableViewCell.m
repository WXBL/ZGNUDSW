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
        [self addSubview:self.farmImage];
        [self.layer setCornerRadius:5];
        
    }
    
    return self;
}

@end
