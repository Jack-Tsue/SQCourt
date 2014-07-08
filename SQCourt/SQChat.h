//
//  Chat.h
//  SQCourt
//
//  Created by Jack on 25/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQChat : NSObject
@property (nonatomic, strong) NSString *chatID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *isJudge;
@end
