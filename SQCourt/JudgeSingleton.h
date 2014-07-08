//
//  JudgeSingleton.h
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeSingleton : NSObject
+ (id)sharedInstance;
- (void)setName:(NSString *)name;
- (void)setCode:(NSString *)code;
- (NSString *)getName;
- (NSString *)getCode;
@end
