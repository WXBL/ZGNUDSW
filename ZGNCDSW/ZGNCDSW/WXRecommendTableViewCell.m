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
            
//            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, recommView.frame.size.width-1, recommView.frame.size.height / 4)];
//            self.titleLabel.textAlignment = NSTextAlignmentCenter;
//            self.titleLabel.font = [UIFont systemFontOfSize:14];
//            self.titleLabel.backgroundColor = [UIColor whiteColor];
//            [recommView addSubview:self.titleLabel];
            
            switch (recommView.tag) {
                case 1:
                    self.salesImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, recommView.frame.size.width-1, recommView.frame.size.height)];
                    [self.salesImage setImage:[UIImage imageNamed:@"recomm_list1"]];
                    
                    [recommView addSubview:self.salesImage];
//                    
//                    self.titleLabel.text = @"优惠推荐";
//                    self.titleLabel.textColor = [UIColor colorWithRed:0.9 green:0.3 blue:0.2 alpha:1];

                    break;
                case 2:
                    
                    
                    
                    self.newproductsImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, recommView.frame.size.width-1, recommView.frame.size.height / 2-1)];
                    [self.newproductsImage setImage:[UIImage imageNamed:@"recomm_list2"]];
                    
                    [recommView addSubview:self.newproductsImage];
    
                    self.fineImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, recommView.frame.size.height / 2, recommView.frame.size.width-1, recommView.frame.size.height /2-1)];
                    [self.fineImage setImage:[UIImage imageNamed:@"recomm_list3"]];
                    
                    [recommView addSubview:self.fineImage];
                    
//                    self.titleLabel.text = @"新品推荐";
//                    self.titleLabel.textColor = [UIColor colorWithRed:0.9 green:0.3 blue:0.2 alpha:1];
                    
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    self.point=[touch locationInView:self];
    NSLog(@"point=%lf,%lf",self.point.x,self.point.y);
    [self setNeedsDisplay];
    NSInteger i;
    if ((int)(self.point.y/(CGRectGetHeight(self.frame)/2))==0) {
        i=(int)self.point.x/(CGRectGetWidth(self.frame)/3);
    }else if((int)(self.point.y/(CGRectGetHeight(self.frame)/2))==1 && (int)(self.point.x/(CGRectGetWidth(self.frame)/3))==0){
        i=0;
    }else if((int)(self.point.y/(CGRectGetHeight(self.frame)/2))==1){
        i=(int)(self.point.x-(CGRectGetWidth(self.frame)/3))/(CGRectGetWidth(self.frame)/3)+3;
    }
    NSLog(@"%ld",i);
    NSNotification *notice=[NSNotification notificationWithName:@"recommend" object:nil userInfo:@{@"click":[NSString stringWithFormat:@"%ld",i]}];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}
@end
