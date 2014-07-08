//
//  JudgeTableViewController.h
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SQJudge.h"

@interface JudgeTableViewController : UITableViewController <MBProgressHUDDelegate, NSXMLParserDelegate> {
    MBProgressHUD *HUD;
    NSString *currentTagName;
    NSMutableString *currentValue;
}
@property (nonatomic, copy) NSString *depNum;
@property (nonatomic, copy) NSMutableArray *judges;
@property (nonatomic) BOOL isShow;
@property (strong, retain) IBOutlet UIBarButtonItem *logoutBtn;
@end
