//
//  SendConversationViewController.h
//  SQCourt
//
//  Created by Jack on 24/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SendConversationViewController : UIViewController<MBProgressHUDDelegate, NSXMLParserDelegate>
@property (nonatomic, strong) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) IBOutlet UIButton *submitBtn;

@end
