//
//  WXtoolbarView.h
//  ZGNCDSW
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WXAddressToolbarDelegate <NSObject>

@optional
-(void)addressToolBar:(UIView *)toolBar didClickButton:(UIButton *)button;

@end

@interface WXtoolbarView : UIView

@property (nonatomic,strong)id<WXAddressToolbarDelegate>delegate;


+(instancetype)toolbar;

//存放所有的按钮
@property (nonatomic,strong)NSMutableArray *btns;

@property (nonatomic,strong)UIButton *editBtn;
@property (nonatomic,strong)UIButton *deleteBtn;
@property (nonatomic,strong)UIButton *defaultBtn;

@property (nonatomic,strong)UIButton *setDefaultBtn;
@property(nonatomic,assign)NSInteger theTag;
@end
