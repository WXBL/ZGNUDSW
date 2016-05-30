//
//  WXOptionPickerView.m
//  ZGNCDSW
//
//  Created by admin on 16/5/30.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXOptionPickerView.h"

@implementation WXOptionPickerView

-(id)initWithOptions:(NSArray *)options frame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _options = options;
        [self loadView];
    }
    return self;
}

#pragma mark -Public methods
- (void)show
{
    _optionTableView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, _optionTableView.frame.size.width, _optionTableView.frame.size.height);
    _topView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, _topView.frame.size.width, _topView.frame.size.height);
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop
                     animations:^{
                         _optionTableView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 256, [[UIScreen mainScreen] bounds].size.width, 256);
                         _topView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 300, _topView.frame.size.width, _topView.frame.size.height);
                         
                     } completion:^(BOOL isFinished){
                         
                     }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionFlipFromTop
                     animations:^{
                         _optionTableView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, _optionTableView.frame.size.width, _optionTableView.frame.size.height);
                         _topView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, _topView.frame.size.width, _topView.frame.size.height);
                         
                     } completion:^(BOOL isFinished){
                         [self removeFromSuperview];
                     }];
}


-(void)loadView{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, screenHeigth/2, screenWidth, 44)];
    self.topView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    self.canceleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.canceleBtn.frame = CGRectMake(10, 8, 50, 28);
    [self.canceleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.canceleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.canceleBtn.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.canceleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.canceleBtn addTarget:self action:@selector(cancelSelection:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.canceleBtn];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth, self.topView.frame.size.height)];
    self.titleLabel.text = @"请选择";
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:self.titleLabel];
    
    [self addSubview:self.topView];
    
    self.optionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), screenWidth, screenHeigth/2-self.topView.frame.size.height) style:UITableViewStylePlain];
    self.optionTableView.delegate = self;
    self.optionTableView.dataSource = self;
    [self.optionTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self addSubview:self.optionTableView];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.titleLabel setText:title];
    [self.titleLabel sizeToFit];
    [self.titleLabel setCenter:CGPointMake(self.topView.frame.size.width/2, self.topView.frame.size.height/2)];
}

-(void)cancelSelection:(id)sender{
    if ([_delegate respondsToSelector:@selector(optionPickerViewDidCancel:)]) {
        [_delegate performSelector:@selector(optionPickerViewDidCancel:) withObject:self];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.options.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *optionCell = @"optionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:optionCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:optionCell];
    }
    NSString *option = [self.options objectAtIndex:indexPath.row];
    cell.textLabel.text = option;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(optionPickerView:didSelectOptionAtIndex:)]) {
        [_delegate performSelector:@selector(optionPickerView:didSelectOptionAtIndex:) withObject:self withObject:[NSNumber numberWithInteger:indexPath.row]];
    }
}
@end
