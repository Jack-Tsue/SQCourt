//
//  Topic.h
//  SQCourt
//
//  Created by Jack on 9/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SQProcess.h"

@interface SQTopic : NSObject
@property (nonatomic, strong) NSString *topicName;
@property (nonatomic, strong) NSMutableArray *processes;
@end