//
//  SQConversation.h
//  SQJudge
//
//  Created by Jack on 25/4/14.
//  Copyright (c) 2014 Faxi Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQConversation : NSObject
@property(nonatomic, retain) NSString *conversationID;
@property(nonatomic, retain) NSString *judgeID;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *judgeName;
@property(nonatomic, retain) NSString *phone;
@property(nonatomic, retain) NSString *unread;
@property(nonatomic, retain) NSString *time;
- (NSString *)getTime;
@end
