//
//  DepartmentTableViewController.h
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DepartmentTableViewController : UITableViewController <MBProgressHUDDelegate, NSXMLParserDelegate> {
    MBProgressHUD *HUD;
    NSString *currentTagName;
    NSMutableString *currentValue;
}
@property (nonatomic, copy) NSMutableArray *departments;
@end