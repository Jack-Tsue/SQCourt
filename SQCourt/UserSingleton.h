//
//  UserSingleton.h
//  SQCourt
//
//  Created by Jack on 15/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSingleton : NSObject
+ (id)sharedInstance;
- (void)setUserName:(NSString *)userName;
- (void)setUserID:(NSString *)userID;
- (void)setCaseID:(NSString *)caseID;
- (void)setName:(NSString *)name;
- (void)setPhone:(NSString *)phone;
- (void)setPswd:(NSString *)password;
- (NSString *)getUserName;
- (NSString *)getUserID;
- (NSString *)getCaseID;
- (NSString *)getName;
- (NSString *)getPhone;
- (NSString *)getPswd;
@end
