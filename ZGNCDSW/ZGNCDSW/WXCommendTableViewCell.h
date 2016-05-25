//
//  WXCommendTableViewCell.h
//  ZGNCDSW
//
//  Created by admin on 16/5/24.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXCommendTableViewCell : UITableViewCell


@property (nonatomic,strong)UIImageView *productImage;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *priceLabel;
@property (nonatomic,strong)UILabel *categoryLabel;
@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UILabel *productNum;
//@property (nonatomic,strong)UILabel *totalLabel;
//
//@property (nonatomic,strong)UIButton *deleteOrder;
//@property (nonatomic,strong)UIButton *logistics;//物流
//@property (nonatomic,strong)UIButton *rated;//评价

@end
