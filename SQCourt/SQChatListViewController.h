//
//  SQChatListViewController.h
//  SQJudge
//
//  Created by Jack on 25/4/14.
//  Copyright (c) 2014 Faxi Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SQChatListViewController : UITableViewController<MBProgressHUDDelegate, NSXMLParserDelegate>
@property (strong, retain) IBOutlet UISegmentedControl *segControl;
@property (strong, retain) IBOutlet UIBarButtonItem *logoutBtn;
@end
