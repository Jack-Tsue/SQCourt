//
//  JudgeSingleton.m
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "JudgeSingleton.h"
#import "Macro.h"
static NSString *judgeCode;
static NSString *judgeName;

@implementation JudgeSingleton

+ (id)sharedInstance
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        judgeCode = @"";
        judgeName = @"";
        return [[self alloc] init];
    });
}

- (void)setName:(NSString *)name
{
    judgeName = name;
}

- (void)setCode:(NSString *)code
{
    judgeCode = code;
}

- (NSString *)getName
{
    return judgeName;
}

- (NSString *)getCode
{
    return judgeCode;
}
@end
