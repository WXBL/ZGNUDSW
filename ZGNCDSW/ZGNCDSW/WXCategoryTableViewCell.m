//
//  WXCategoryTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXCategoryTableViewCell.h"
#import "PrefixHeader.pch"


@implementation WXCategoryTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 180)];
        categoryView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self addSubview:categoryView];

        
        for (int i = 0; i < 4; i++) {
            
            // 创建一个UIImageView
            UIImageView *imgView = [[UIImageView alloc] init];
            
            
            // 计算每个UIImageView在UIScrollView中的x坐标值
            CGFloat imgW = screenWidth * 0.25 -40;
            CGFloat imgH = 60;
            
            CGFloat imgY = 5;
            CGFloat imgX = i * screenWidth * 0.25 +20;
            // 设置UIImageView中的图片
            NSString *imgName = [NSString stringWithFormat:@"category_list%d", i + 1];
            imgView.image = [UIImage imageNamed:imgName];
            // 设置imgView的frame
            imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
            
            UILabel *cateLabel = [[UILabel alloc]initWithFrame:CGRectMake(i *screenWidth * 0.25, 60, screenWidth * 0.25, 30)];
            cateLabel.textAlignment = NSTextAlignmentCenter;
            cateLabel.font = [UIFont systemFontOfSize:12];
            switch (i) {
                case 0:
                    cateLabel.text = @"农资超市";
                    break;
                case 1:
                    cateLabel.text = @"农资超市";
                    break;
                case 2:
                    cateLabel.text = @"农资超市";
                    break;
                case 3:
                    cateLabel.text = @"农资超市";
                    break;
                case 4:
                    cateLabel.text = @"农资超市";
                    break;
                default:
                    break;
            }
            
            self.categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.categoryButton.frame = CGRectMake(i * screenWidth *0.25, 0, screenWidth * 0.25, 90);
            self.categoryButton.tag = i+1;
            [self.categoryButton setBackgroundColor:[UIColor whiteColor]];
//            [self.categoryButton setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
            [categoryView addSubview:self.categoryButton];
            
            [categoryView addSubview:imgView];
            
            [categoryView addSubview:cateLabel];
           
            

        }
        for (int j = 0; j < 4; j++) {
            
            // 创建一个UIImageView
            UIImageView *imgView = [[UIImageView alloc] init];
            
            
            // 计算每个UIImageView在UIScrollView中的x坐标值
            CGFloat imgW = screenWidth * 0.25 -40;
            CGFloat imgH = 60;
            CGFloat imgY = 96;
            CGFloat imgX = j * screenWidth * 0.25 + 20;
            // 设置UIImageView中的图片
            NSString *imgName = [NSString stringWithFormat:@"category_list%d", j + 1];
            imgView.image = [UIImage imageNamed:imgName];
            // 设置imgView的frame
            imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
            
            UILabel *cateLabel = [[UILabel alloc]initWithFrame:CGRectMake(j *screenWidth * 0.25, 150, screenWidth * 0.25, 30)];
            cateLabel.textAlignment = NSTextAlignmentCenter;
            cateLabel.font = [UIFont systemFontOfSize:12];
            switch (j) {
                case 0:
                    cateLabel.text = @"农资超市";
                    break;
                case 1:
                    cateLabel.text = @"农资超市";
                    break;
                case 2:
                    cateLabel.text = @"农资超市";
                    break;
                case 3:
                    cateLabel.text = @"农资超市";
                    break;
                case 4:
                    cateLabel.text = @"农资超市";
                    break;
                default:
                    break;
            }
            
            self.categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.categoryButton.frame = CGRectMake(j * screenWidth *0.25, 90, screenWidth * 0.25, 90);
            self.categoryButton.tag = j+5;
            [self.categoryButton setBackgroundColor:[UIColor whiteColor]];
            [categoryView addSubview:self.categoryButton];
            
            [categoryView addSubview:imgView];
            
            [categoryView addSubview:cateLabel];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
