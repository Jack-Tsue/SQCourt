//
//  UserSingleton.m
//  SQCourt
//
//  Created by Jack on 15/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "UserSingleton.h"
#import "Macro.h"
static NSString *_userName;
static NSString *_userID;
static NSString *_name;
static NSString *_phone;
static NSString *_caseID;
static NSString *_pswd;

@implementation UserSingleton
+ (id)sharedInstance
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        _userName = @"";
        _userID = @"";
        _name = @"";
        _phone = @"";
        _caseID = @"";
        _pswd = @"";
        return [[self alloc] init];
    });
}

- (void)setUserName:(NSString *)userName
{
    _userName = userName;
}
- (void)setUserID:(NSString *)userID
{
    _userID = userID;
}
-(void)setCaseID:(NSString *)caseID
{
    _caseID = caseID;
}
- (void)setName:(NSString *)name
{
    _name = name;
}
- (void)setPhone:(NSString *)phone
{
    _phone = phone;
}
- (NSString *)getUserName
{
    return _userName;
}
- (NSString *)getUserID
{
    return _userID;
}
- (NSString *)getCaseID
{
    return _caseID;
}
- (NSString *)getName
{
    return _name;
}
- (NSString *)getPhone
{
    return _phone;
}
- (void)setPswd:(NSString *)password
{
    _pswd = password;
}
- (NSString *)getPswd
{
    return _pswd;
}
@end
