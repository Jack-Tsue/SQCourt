//
//  AdviceReply.h
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQAdviceReply : NSObject
@property (nonatomic, copy) NSString *adivceID;
@property (nonatomic, copy) NSString *replyID;
@property (nonatomic, copy) NSString *judgeID;
@property (nonatomic, copy) NSString *replyTime;
@property (nonatomic, copy) NSString *replyContent;
- (NSString *)getReplyDate;
@end
