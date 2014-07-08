//
//  Advice.m
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "SQAdvice.h"

@implementation SQAdvice
- (NSString *)type
{
    if ([_type isEqualToString:@"1"]) {
        return @"法律咨询";
    }
    if ([_type isEqualToString:@"2"]) {
        return @"投诉举报";
    }
    if ([_type isEqualToString:@"3"]) {
        return @"意见建议";
    }
    if ([_type isEqualToString:@"4"]) {
        return @"院长留言";
    }
    return nil;
}

- (NSString *)time
{
    // NSLog(@"time: %@", _time);
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:([_time doubleValue]/1000)];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString *destDateString = [dateFormatter stringFromDate:localeDate];
    
    return destDateString;
}
@end
