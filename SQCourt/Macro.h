//
//  Macro.h
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#ifndef SQCourt_Macro_h
#define SQCourt_Macro_h


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height 
#define isIos7System [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define TINTBLUE [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \

#define SERVER_ADDRESS @"http://61.147.251.189:80/"
#define INTERFACE_ADDRESS @"http://61.147.251.189:80/minterface/"
#define TEST_INTERFACE_ADDRESS @"http://192.168.68.43:8880/minterface/"

#define kSSServiceName @"cn.nanjing.faxitech.suqian.useraccount"

#endif
