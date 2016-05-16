//
//  WXRecommendTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/4/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXRecommendTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *salesImage; //促销
@property (nonatomic,strong)UIImageView *newproductsImage;//新品
@property (nonatomic,strong)UIImageView *hotImage;  //热卖
@property (nonatomic,strong)UIImageView *fineImage; //精品
@property (nonatomic,strong)UIImageView *phoneVipImage; //手机专享

@property (nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,assign)CGPoint point;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
@end
