
//
//  WXBigPic.m
//  ZGNCDSW
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXBigPic.h"

static CGRect oldframe;

@implementation WXBigPic

+(void)showImage:(UIImageView*)avatarImageView{
    
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeigth)];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0, (screenHeigth -image.size.height*screenWidth / image.size.width)/2,screenWidth , image.size.height*screenWidth/image.size.width);
        backgroundView.alpha = 1;
    }completion:^(BOOL finished){
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
    
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    }completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
    }];
}
@end
