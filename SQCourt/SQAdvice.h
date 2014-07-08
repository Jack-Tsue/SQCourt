//
//  Advice.h
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQAdvice : NSObject
@property (nonatomic, copy) NSString *adivceID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *adviceContent;
@property (nonatomic, copy) NSString *bt;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *time;
- (NSString *)type;
- (NSString *)time;
@end
