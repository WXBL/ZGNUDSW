//
//  WXSearchBar.m
//  ZGNCDSW
//
//  Created by admin on 16/4/26.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXSearchBar.h"
#import "UIView+Extension.h"
#import "PrefixHeader.pch"
@implementation WXSearchBar

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入想要搜索的商品";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        
        // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    self = [super initWithFrame:frame];
//    
//    if (self) {
//        
//        // 设置字体
//        self.font = [UIFont systemFontOfSize:13];
//        
//        // 设置背景
//        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
//        self.placeholder = @"请输入想要搜索的商品";
//        
//        // 设置左边的view
//        [self setLeftView];
//        
//        // 设置右边的录音按钮
//        //        [self setRightView];
//        
//    }
//    
//    return self;
//}
//
-(instancetype)init{
    
    // 设置frame
    CGFloat width = WXMainScreenBounds.size.width - 110;
    CGFloat height = 30;
    //    CGFloat X = (SCMainScreenBounds.size.width - width) * 0.5;
    CGFloat X=screenWidth-width-20;
    CGFloat Y = 7;
    CGRect frame = CGRectMake(X, Y, width, height);
    
    return [self initWithFrame:frame];

}

+(instancetype)searchBar{
    return [[self alloc]init];
}

//
//// 设置左边的view
//- (void)setLeftView {
//    
//    // initWithImage:默认UIImageView的尺寸跟图片一样
//    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
//    
//    
//    self.leftView = leftImageView;
//    //  注意：一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
//    self.leftViewMode = UITextFieldViewModeAlways;
//}

@end
