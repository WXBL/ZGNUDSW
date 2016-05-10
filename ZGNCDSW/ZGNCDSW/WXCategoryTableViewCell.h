//
//  WXCategoryTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/4/27.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXCategoryTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *Categoryimages;
@property (nonatomic,strong)UIButton *categoryButton;
@property(nonatomic,assign)CGPoint point;
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
@end
