//
//  UILabel+WXStringFrame.m
//  ZGNCDSW
//
//  Created by 龙莲莲 on 16/5/13.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "UILabel+WXStringFrame.h"

@implementation UILabel (WXStringFrame)
- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}
@end
