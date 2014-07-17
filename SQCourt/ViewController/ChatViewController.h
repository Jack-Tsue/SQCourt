//
//  ChatViewController.h
//  SQCourt
//
//  Created by Jack on 16/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessagesViewController.h"
#import "MBProgressHUD.h"

@class SQConversation;

@interface ChatViewController : JSMessagesViewController <JSMessagesViewDelegate, JSMessagesViewDataSource, MBProgressHUDDelegate, NSXMLParserDelegate>
@property (nonatomic, retain) SQConversation *conversation;
@property (nonatomic) BOOL isContactJudge;
@end
