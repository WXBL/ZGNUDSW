//
//  ViewUtil.m
//  Hbsj
//
//  Created by 小小世界 on 14/10/28.
//  Copyright (c) 2014年 mSquare. All rights reserved.
//

#import "MViewUtil.h"
#import "MBProgressHUD.h"
#import "SHLUILabel.h"
@implementation MViewUtil
+(id)instance
{
    MViewUtil *instance = [[MViewUtil alloc] init];
    return instance;
}

- (void) showShortDurationMessage:(NSString*)text targetView:(UIView *)targetView
{
    // display a message similar to loading spinner, but we will hide it in a while
    for (UIView *view in targetView.subviews) {
        if ([NSStringFromClass(view.class) isEqualToString:@"MBProgressHUD"]) {
            [view removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:targetView];
    if(hud == nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    }
    //    hud.labelText = text;
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:3];
}

- (void)showLoadingText:(NSString *)text targetView:(UIView *)targetView
{
    // display a nice loading spinner
    for (UIView *view in targetView.subviews) {
        if ([view isKindOfClass:[MBProgressHUD class]]) {
            [view removeFromSuperview];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:targetView];
    if(hud == nil)
    {
        hud = [MBProgressHUD showHUDAddedTo:targetView animated:YES];
    }
    hud.labelText = text;
}


- (void) hideLoadingTextFromTargetView:(UIView *)targetView
{
    // make sure we hide it
    if ([NSThread isMainThread]) {
        [MBProgressHUD hideAllHUDsForView:targetView animated:NO];
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:targetView animated:NO];
        });
    }
}

- (UIViewController *)getViewControllerWithView:(UIView *)view
{
    for (UIView* next = view.superview; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
-(void)resizeLabel:(UILabel *) label  fontSize:(int)fontSize lineSpacing:(CGFloat)lineSpacing
{
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    NSMutableAttributedString *attrituteString =  [[NSMutableAttributedString alloc] initWithString:label.text];
    [attrituteString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attrituteString;
    SHLUILabel *hidden = [[SHLUILabel alloc]initWithFrame:label.frame];
    hidden.font = [UIFont systemFontOfSize:fontSize];
    hidden.text = label.text;
    CGFloat height = [hidden getAttributedStringHeightWidthValue:label.frame.size.width];
    if (label.frame.size.height<height) {
        label.frame =CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, height);
    }else{
        label.frame =CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, label.frame.size.height);
    }
}
-(void)resizeLabel:(UILabel *) label preFrame:(CGRect)preFrame nextFrame:(CGRect)nextFrame fontSize:(int)fontSize{
    [self resizeLabel:label preFrame:preFrame nextFrame:nextFrame fontSize:fontSize lineSpacing:1.5f];
}

-(void)resizeLabel:(UILabel *) label preFrame:(CGRect)preFrame nextFrame:(CGRect)nextFrame fontSize:(int)fontSize lineSpacing:(CGFloat)lineSpacing
{
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    NSMutableAttributedString *attrituteString =  [[NSMutableAttributedString alloc] initWithString:label.text];
    [attrituteString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attrituteString;
    SHLUILabel *hidden = [[SHLUILabel alloc]initWithFrame:label.frame];
    hidden.font = [UIFont systemFontOfSize:fontSize];
    hidden.text = label.text;
    CGFloat height = [hidden getAttributedStringHeightWidthValue:label.frame.size.width];
    if (label.frame.size.height<height) {
        label.frame =CGRectMake(label.frame.origin.x, preFrame.origin.y +preFrame.size.height, label.frame.size.width, height);
    }else{
        label.frame =CGRectMake(label.frame.origin.x, preFrame.origin.y +preFrame.size.height, label.frame.size.width, label.frame.size.height);
    }
}

@end
