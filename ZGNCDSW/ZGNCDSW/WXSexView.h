//
//  WXSexView.h
//  ZGNCDSW
//
//  Created by admin on 16/5/12.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WXSexViewDelegate <NSObject>

@optional
-(void)WXSexView:(UIView *)sexView didClickButton:(UIButton *)button;

@end


@interface WXSexView : UIView

@property (nonatomic,strong)id <WXSexViewDelegate>delegate;

@property(nonatomic,strong)UIView *sexView;
@property (nonatomic,strong)UIButton *manButton;
@property (nonatomic,strong)UIButton *girlButton;
@property (nonatomic,strong)UIButton *cancelButton;

@end
