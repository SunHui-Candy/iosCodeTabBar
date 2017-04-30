//
//  NSDate+SHDate.m
//  SHCode
//
//  Created by ios on 17/4/17.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "NSDate+SHDate.h"

@implementation NSDate (SHDate)

+ (NSString *)createDateStr:(NSString *)createAtStr
{
    // 1.创建时间格式化对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MM dd HH:mm:ss Z yyyy";
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    // 2.将字符串时间,转成NSDate类型
    NSDate *createDate = [fmt dateFromString:createAtStr];
    
    // 3.创建当前时间
    NSDate *nowDate = [NSDate date];
    // 4.计算创建时间和当前时间的时间差

    NSTimeInterval interval = [nowDate timeIntervalSinceDate:createDate];
    // 5.对时间间隔处理
    // 5.1.显示刚刚

    if (interval < 60) {
        return @"刚刚";
    }
    // 5.2.59分钟前

    if (interval < 60 * 60) {
        return kFormat(@"%.f分钟前", interval / 60);
    }
    // 5.3.11小时前

    if (interval < 60 * 60 * 24) {
        return kFormat(@"%.f小时前", interval / (60 * 60));
    }
    // 5.4.创建日历对象

   NSCalendar *calendar = [NSCalendar currentCalendar];
    // 5.5.处理昨天数据: 昨天 12:23

    if ([calendar isDateInYesterday:createDate]) {
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }
    // 5.6.处理一年之内: 02-22 12:22

   NSDateComponents *cmp = [calendar components:NSCalendarUnitYear fromDate:createDate toDate:nowDate options:NSCalendarWrapComponents];
    if (cmp.year < 1) {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    // 5.7.超过一年: 2014-02-12 13:22
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    return [fmt stringFromDate:createDate];
    
}
@end
