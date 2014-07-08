//
//  NewConversationViewController.h
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface NewConversationViewController : UIViewController <MBProgressHUDDelegate, NSXMLParserDelegate>
@property(nonatomic,retain) IBOutlet UITextField *nameTextField;
@property(nonatomic,retain) IBOutlet UITextField *phoneTextField;
@property(nonatomic,retain) IBOutlet UIButton *createBtn;
@end
