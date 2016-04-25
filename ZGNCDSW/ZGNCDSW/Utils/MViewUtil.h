//
//  ViewUtil.h
//  Hbsj
//
//  Created by 小小世界 on 14/10/28.
//  Copyright (c) 2014年 mSquare. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MViewUtil : NSObject
+(id)instance;

- (void) showShortDurationMessage:(NSString*)text targetView:(UIView *)targetView;

- (void)showLoadingText:(NSString *)text targetView:(UIView *)targetView;

- (void) hideLoadingTextFromTargetView:(UIView *)targetView;

- (UIViewController *)getViewControllerWithView:(UIView *)view;

-(void)resizeLabel:(UILabel *) label preFrame:(CGRect)preFrame nextFrame:(CGRect)nextFrame fontSize:(int)fontSize;
-(void)resizeLabel:(UILabel *) label preFrame:(CGRect)preFrame nextFrame:(CGRect)nextFrame fontSize:(int)fontSize lineSpacing:(CGFloat)lineSpacing;
-(void)resizeLabel:(UILabel *) label  fontSize:(int)fontSize lineSpacing:(CGFloat)lineSpacing;
@end
