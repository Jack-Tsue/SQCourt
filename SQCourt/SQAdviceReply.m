//
//  AdviceReply.m
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "SQAdviceReply.h"

@implementation SQAdviceReply
- (NSString *)getReplyDate
{
    // NSLog(@"time: %@", _replyTime);
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:([_replyTime doubleValue]/1000)];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息 +0000。
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:localeDate];
    
    return destDateString;
}

@end
