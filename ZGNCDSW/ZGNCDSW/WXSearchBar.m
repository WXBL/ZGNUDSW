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

+(instancetype)searchBar{
    return [[self alloc]init];
}
@end
