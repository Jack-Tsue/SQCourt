//
//  DetailViewController.h
//  TEST
//
//  Created by Jack on 10/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQProcess.h"
#import "URBMediaFocusViewController.h"

@interface DetailViewController : UIViewController <URBMediaFocusViewControllerDelegate, NSURLConnectionDataDelegate>
@property (nonatomic, retain) SQProcess *process;
@end
