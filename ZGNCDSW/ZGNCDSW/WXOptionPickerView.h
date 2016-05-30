//
//  WXOptionPickerView.h
//  ZGNCDSW
//
//  Created by admin on 16/5/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXOptionPickerView;

@protocol WXOptionPickerViewDelegate <NSObject>

-(void)optionPickerView:(WXOptionPickerView *)pickerView didSelectOptionAtIndex:(NSNumber *)index;
-(void)optionPickerViewDidCancel:(WXOptionPickerView *)pickerView;

@end
@interface WXOptionPickerView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *optionTableView;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIButton *canceleBtn;
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)id<WXOptionPickerViewDelegate>delegate;
@property (nonatomic,strong)NSArray *options;
@property (nonatomic,copy)NSString *title;

-(id)initWithOptions:(NSArray *)options frame:(CGRect)frame;
-(void)show;
-(void)dismiss;

@end
