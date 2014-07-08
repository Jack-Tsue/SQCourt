//
//  NoticeViewController.h
//  TEST
//
//  Created by Jack on 3/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NoticeViewController : UITableViewController <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}
@property (nonatomic, copy) NSMutableArray *notices;
@property (nonatomic, strong) NSString *currentTagName;
@end
