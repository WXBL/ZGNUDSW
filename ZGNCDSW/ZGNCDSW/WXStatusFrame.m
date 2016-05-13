//
//  WXStatusFrame.m
//  ZGNCDSW
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXStatusFrame.h"

@implementation WXStatusFrame

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

//重写set方法
-(void)setStatus:(WXStatusModel *)status
{
    _status = status;
    
    WXUserModel *user = status.user;
    
    //cell的宽度
    CGFloat cellW = screenWidth;
    
    
    //昵称
    CGFloat nameX = StatusCellBorderW;
    CGFloat nameY = StatusCellBorderW;
    CGSize nameSize = [self sizeWithText:user.UserName font:StatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    //评论正文
    CGFloat commentContentX = nameX;
    CGFloat commentContentY = MAX(CGRectGetMaxY(self.nameLabelF),StatusCellBorderW);
    CGFloat maxW = cellW-2*commentContentX;
    CGSize commentSize = [self sizeWithText:status.Comment_Content font:StatusCellContentFont maxW:maxW];
    self.commentContentF = (CGRect){{commentContentX,commentContentY},commentSize};
    
    //时间
    CGFloat commentTimeX = nameX;
    CGFloat commentTimeY = CGRectGetMaxY(self.nameLabelF)+CGRectGetMaxY(self.commentContentF)+StatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.Comment_Time font:StatusCellTimeFont];
    self.commentTimeF = (CGRect){{commentTimeX,commentTimeY},timeSize};
    
    CGFloat categoryX = CGRectGetMaxX(self.commentTimeF);
    CGFloat categoryY = CGRectGetMaxY(self.nameLabelF)+CGRectGetMaxY(self.commentContentF)+StatusCellBorderW;
    CGSize categorySize = [self sizeWithText:status.category font:StatusCellTimeFont];
    self.categoryF = (CGRect){{categoryX,categoryY},categorySize};
    
    //评论整体
    CGFloat commentX = 0;
    CGFloat commentY = StatusCellMargin;
    CGFloat commentW = cellW;
    CGFloat commentH = 0;
    self.commentViewF = CGRectMake(commentX, commentY, commentW, commentH);
    
    //cell的高度
    self.cellHeight = CGRectGetMaxY(self.commentTimeF);
}

@end
