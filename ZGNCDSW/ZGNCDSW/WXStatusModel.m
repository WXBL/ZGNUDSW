//
//  WXStatusModel.m
//  ZGNCDSW
//
//  Created by admin on 16/5/5.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "WXStatusModel.h"

@implementation WXStatusModel


-(NSString *)Comment_Time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //如果真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    //评论时间
    NSDate *commentTime = [fmt dateFromString:_Comment_Time];
    //当前时间
//    NSDate *nowtime = [NSDate date];
//    //日历对象（方便比较两个日期间的差距）
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    //NSCalendarUnit枚举代表想获得哪些差值
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitWeekOfMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
//    NSDateComponents *cmps = [calendar components:unit fromDate:commentTime toDate:nowtime options:0];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    return [fmt stringFromDate:commentTime];
}
@end
