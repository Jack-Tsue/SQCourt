//
//  LoginWithCaseIDViewController.h
//  SQCourt
//
//  Created by Jack on 20/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface LoginWithCaseIDViewController : UIViewController<UIAlertViewDelegate, NSXMLParserDelegate, MBProgressHUDDelegate, UITextFieldDelegate>
@property(nonatomic, strong) IBOutlet UIImageView *logoImage;
@property(nonatomic, strong) IBOutlet UITextField * caseIDTextField;
@property(nonatomic, strong) IBOutlet UIButton *loginBtn;
@end
