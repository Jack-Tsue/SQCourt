//
//  JudgeViewController.h
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface JudgeViewController : UIViewController<NSURLConnectionDataDelegate>
@property (nonatomic, retain) NSString *judgePic;
@property (nonatomic, retain) NSString *judgeResume;
@property (nonatomic, retain) NSString *judgeID;
@property (nonatomic, retain) NSString *judgeName;
@end
