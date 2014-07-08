//
//  AdviceViewController.h
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQAdvice.h"
#import "MBProgressHUD.h"

@interface AdviceViewController : UITableViewController<MBProgressHUDDelegate, NSXMLParserDelegate>
@property (nonatomic, strong) SQAdvice *advice;
@end
