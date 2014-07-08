//
//  UUIDHelper.m
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "UUIDHelper.h"
#import "KeychainItemWrapper.h"

@implementation UUIDHelper
+ (NSString *)generateUUID
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID"  accessGroup:@"cn.nanjing.faxitech.suqian.userinfo"];
    NSString *strUUID = [keychainItem objectForKey:(id)kSecValueData];
    if ([strUUID isEqualToString:@""])
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFUUIDCreateString (kCFAllocatorDefault,uuidRef);
        [keychainItem setObject:strUUID forKey:(id)kSecValueData];
    }
    [keychainItem release];
    // NSLog(@"uuid: %@/n", strUUID);
    return strUUID;
}
@end
