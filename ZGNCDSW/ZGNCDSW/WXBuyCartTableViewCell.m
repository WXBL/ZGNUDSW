//
//  WXBuyCartTableViewCell.m
//  ZGNCDSW
//
//  Created by admin on 16/5/6.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXBuyCartTableViewCell.h"
static NSInteger num=0;
@implementation WXBuyCartTableViewCell{
    
    BOOL isBool;
    
    NSIndexPath *indexPath;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIView *cartBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
//        cartBgView.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
//        [self addSubview:cartBgView];
        //勾选按钮
        self.chooseButton = [ShoppingBtn buttonWithType:UIButtonTypeCustom];
        self.chooseButton.frame = CGRectMake(10, 45, 30, 30);
        [self.chooseButton addTarget:self action:@selector(ClickChooseButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.chooseButton];
        
        self.productImage = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 100, 100)];
        [self.productImage.layer setCornerRadius:5];
//        [self.productImage setImage:[UIImage imageNamed:@"news_list1"]];
        [self addSubview:self.productImage];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 0, screenWidth - 180, 40)];
        self.titleLabel.textColor = [UIColor grayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 2;
        [self addSubview:self.titleLabel];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, CGRectGetMaxY(self.titleLabel.frame) , screenWidth - 230, 30)];
        self.priceLabel.textColor = [UIColor colorWithRed:0.3 green:0.7 blue:0.5 alpha:1];
        self.priceLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.priceLabel];
        
        self.buyNum = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 50, CGRectGetMaxY(self.titleLabel.frame) , 50, 30)];
        self.buyNum.textColor = [UIColor blackColor];
        self.buyNum.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.buyNum];
        
        
        self.editView = [[UIView alloc]initWithFrame:CGRectMake(180, 70, screenWidth-180, 50)];
        self.editView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.editView];
        
        self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reduceButton.frame = CGRectMake(0, 0, 50, 50);
        [self.reduceButton setTitle:@"-" forState:UIControlStateNormal];
        [self.reduceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.editView addSubview:self.reduceButton];
        
        self.buyNumLabel = [[UILabel alloc]init];
        self.buyNumLabel.frame = CGRectMake(CGRectGetMaxX(self.reduceButton.frame),10, 80, 30);
        self.buyNumLabel.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.buyNumLabel.textColor = [UIColor blackColor];
        self.buyNumLabel.textAlignment = NSTextAlignmentCenter;
        [self.editView addSubview:self.buyNumLabel];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.frame = CGRectMake(CGRectGetMaxX(self.buyNumLabel.frame),0, 50, 50);
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.editView addSubview:self.addButton];
        
        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteButton.frame = CGRectMake(CGRectGetMaxX(self.addButton.frame), 10, 50, 30);
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.deleteButton setBackgroundColor: [UIColor redColor]];
        [self.deleteButton.layer setCornerRadius:5];
        [self.editView addSubview:self.deleteButton];
        
        [self.reduceButton addTarget:self action:@selector(ClickReduceButton:) forControlEvents:UIControlEventTouchDown];
        
        [self.addButton addTarget:self action:@selector(ClickAddButton:) forControlEvents:UIControlEventTouchDown];
        
        
    }
    return self;
}

-(void)setModel:(WXShoppingCellModel *)model{
    _model = model;
    
    indexPath = [NSIndexPath indexPathForRow:model.row inSection:model.section];
    
    self.reduceButton.tag = indexPath.row;
    self.addButton.tag = indexPath.row;
    
    self.productImage.image = [UIImage imageNamed:_model.imageUrl];
    self.titleLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",model.numInt];
    self.buyNum.text = [NSString stringWithFormat:@"X%ld",model.numInt];
    self.numInteger = model.numInt;
    if (model.cellClickState == 1) {
        
        isBool = YES;
        [self.chooseButton setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
        
    } else {
        
        isBool = NO;
        [self.chooseButton setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
    }
    
    if (model.cellEditState ==1) {
        
        self.editView.hidden = NO;
        
    }else{
        
        self.editView.hidden = YES;
        
    }
}

//点击减少数量按钮触发事件
-(void)ClickReduceButton:(UIButton *)sender
{
    num=self.buyNumLabel.text.intValue;
  
        if (num>1) {
            num--;
            self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",num];
            
            self.buyNum.text = [NSString stringWithFormat:@"X%ld",num];
        }else{
            NSLog(@"超出范围");
        }
 
    
}

//点击增加数量按钮触发事件
-(void)ClickAddButton:(UIButton *)sender{
num=self.buyNumLabel.text.intValue;
        num++;
        self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",num];
        self.buyNum.text = [NSString stringWithFormat:@"X%ld",num];

   
}




//-(void)setNumInteger:(NSInteger)numInteger{
//    
//    self.numInteger = numInteger;
//    self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_numInteger];
//    num = self.numInteger;
//}
//
//-(void)setMinInteget:(NSInteger)minInteget{
//    
//    _minInteget = minInteget;
//    if (_minInteget == 0) {
//
//        self.buyNumLabel.text = @"0";
//        num = 0;
//        
//    }else if (_minInteget<=[self.buyNumLabel.text integerValue]){
//
//        self.buyNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_minInteget];
//        num = _minInteget;
//    }
//    
//}


-(void)ClickChooseButton:(UIButton *)sender{
    if (isBool) {
        _model.cellClickState = 0;
         [_delegate WXShoppingTableViewCell:_model];
        [self.chooseButton setImage:[UIImage imageNamed:@"iconfont-yuanquan"] forState:UIControlStateNormal];
        isBool = NO;
    }else{
        _model.cellClickState = 1;
        [_delegate WXShoppingTableViewCell:_model ];
        [self.chooseButton setImage:[UIImage imageNamed:@"iconfont-zhengque"] forState:UIControlStateNormal];
        isBool = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
