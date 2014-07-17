//
//  AdviceViewController.h
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class SQAdvice;

@interface AdviceViewController : UITableViewController<MBProgressHUDDelegate, NSXMLParserDelegate>
@property (nonatomic, strong) SQAdvice *advice;
@end
