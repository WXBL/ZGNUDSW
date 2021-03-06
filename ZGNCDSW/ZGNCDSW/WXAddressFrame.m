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
    return [self sizeWithText:text font:font maxW:screenWidth-20];
}

-(void)setAddress:(WXAddressModel *)address{
    _address=address;
    CGFloat cellW = screenWidth;
    CGFloat toolbarY = 0;
    
    CGFloat usernameX = AddressCellBorderW;
    CGFloat usernameY = AddressCellBorderW;
    CGSize usernameSize = [self sizeWithText:address.username font:AddressCellNameFont];
    self.usernameF = (CGRect){{usernameX,usernameY},usernameSize};
    
    CGFloat phoneX = screenWidth / 2;
    CGFloat phoneY = usernameY;
    CGSize phoneSize = [self sizeWithText:address.Phone font:AddressCellPhoneFont];
    self.phoneF = (CGRect){{phoneX,phoneY},phoneSize};
    
    CGFloat addressDetailX = usernameX;
    CGFloat addtessDetailY = CGRectGetMaxY(self.usernameF)+AddressCellBorderW;
    CGSize addressDetailSize = [self sizeWithText:address.Specific_Address font:AddressCellAddDetailFont];
    self.addressDetailF = (CGRect){{addressDetailX,addtessDetailY},addressDetailSize};
    
    //分割线
    CGFloat lineX = 0;
    CGFloat lineY = CGRectGetMaxY(self.addressDetailF);
    CGFloat lineW = cellW;
    CGFloat lineH = 1.0;
    self.lineF = CGRectMake(lineX, lineY, lineW, lineH);
    
    
    //工具条
    CGFloat toolbarX = 0;
    toolbarY = CGRectGetMaxY(self.lineF);
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 30;
    self.toolBarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    //cell整体
    CGFloat cellViewX = 0;
    CGFloat cellViewY = 0;
    CGFloat cellViewW = cellW;
    CGFloat cellViewH = CGRectGetMaxY(self.toolBarF);
    self.cellViewF = CGRectMake(cellViewX, cellViewY, cellViewW, cellViewH);

    

    
    self.cellHeight = CGRectGetHeight(self.cellViewF)+AddressCellBorderW;
    NSLog(@"cellheight %lf",self.cellHeight);
    
}
@end
