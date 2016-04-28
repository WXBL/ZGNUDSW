//
//  WXRecommendTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXRecommendTableViewCell.h"
#import "PrefixHeader.pch"
@implementation WXRecommendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i= 0 ; i<3; i++) {
            UIView *recommView = [[UIView alloc]initWithFrame:CGRectMake(i * screenWidth / 3, 0, screenWidth /3, 180)];
            recommView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            recommView.tag = i +1;
            
            [self addSubview:recommView];
            
            switch (recommView.tag) {
                case 1:
                    self.salesImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, recommView.frame.size.width-1, recommView.frame.size.height-1)];
                    [self.salesImage setImage:[UIImage imageNamed:@"recomm_list1"]];
                    
                    [recommView addSubview:self.salesImage];

                    break;
                case 2:
                    self.newproductsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, recommView.frame.size.width-1, recommView.frame.size.height / 2-1)];
                    [self.newproductsImage setImage:[UIImage imageNamed:@"recomm_list2"]];
                    
                    [recommView addSubview:self.newproductsImage];
    
                    self.fineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, recommView.frame.size.height / 2, recommView.frame.size.width-1, recommView.frame.size.height /2-1)];
                    [self.fineImage setImage:[UIImage imageNamed:@"recomm_list3"]];
                    
                    [recommView addSubview:self.fineImage];
                    
                    break;
                case 3:
                    self.hotImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, recommView.frame.size.width, recommView.frame.size.height / 2-1)];
                    [self.hotImage setImage:[UIImage imageNamed:@"recomm_list4"]];
                    
                    [recommView addSubview:self.hotImage];
                    
                    self.phoneVipImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, recommView.frame.size.height / 2, recommView.frame.size.width, recommView.frame.size.height /2-1)];
                    [self.phoneVipImage setImage:[UIImage imageNamed:@"recomm_list5"]];
                    
                    [recommView addSubview:self.phoneVipImage];
                    
                    break;
                default:
                    break;
            }
        }
        
        
    }
    
    return self;
}
@end
