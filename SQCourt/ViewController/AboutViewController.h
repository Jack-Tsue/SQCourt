//
//  AboutViewController.h
//  SQCourt
//
//  Created by Jack on 10/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface AboutViewController : UITableViewController<MBProgressHUDDelegate>
@property IBOutlet UILabel *accountLabel;
@property IBOutlet UILabel *nameLabel;
@end
