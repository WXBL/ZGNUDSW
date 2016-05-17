//
//  WXAddressFrame.m
//  ZGNCDSW
//
//  Created by admin on 16/5/16.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXAddressFrame.h"
#import "WXAddressModel.h"
@implementation WXAddressFrame

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

-(void)setAddress:(WXAddressModel *)address{
   
    CGFloat cellW = screenWidth;
    CGFloat toolbarY = 0;
    
    CGFloat usernameX = AddressCellBorderW;
    CGFloat usernameY = AddressCellBorderW;
    CGSize usernameSize = [self sizeWithText:address.username font:AddressCellNameFont];
    self.usernameF = (CGRect){{usernameX,usernameY},usernameSize};
    
    CGFloat phoneX = CGRectGetMaxX(self.usernameF)+AddressCellBorderW;
    CGFloat phoneY = usernameY;
    CGSize phoneSize = [self sizeWithText:address.Phone font:AddressCellPhoneFont];
    self.phoneF = (CGRect){{phoneX,phoneY},phoneSize};
    
    CGFloat addressDetailX = usernameX;
    CGFloat addtessDetailY = CGRectGetMaxY(self.usernameF)+AddressCellBorderW;
    CGSize addressDetailSize = [self sizeWithText:address.Specific_Address font:AddressCellAddDetailFont];
    self.addressDetailF = (CGRect){{addressDetailX,addtessDetailY},addressDetailSize};
    
    
    //工具条
    CGFloat toolbarX = 0;
    toolbarY = CGRectGetMaxY(self.addressDetailF);
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 40;
    self.toolBarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    //cell整体
    CGFloat cellViewX = 0;
    CGFloat cellViewY = 0;
    CGFloat cellViewW = cellW;
    CGFloat cellViewH = CGRectGetMaxY(self.toolBarF)+AddressCellBorderW;
    self.cellViewF = CGRectMake(cellViewX, cellViewY, cellViewW, cellViewH);

    

    
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
    NSLog(@"cellheight %lf",self.cellHeight);
}
@end
