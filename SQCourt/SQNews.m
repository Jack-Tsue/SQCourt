//
//  News.m
//  SQCourt
//
//  Created by Jack on 1/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "SQNews.h"

@implementation SQNews
- (NSString *)getTime {
    
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
