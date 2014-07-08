//
//  LoginViewController.h
//  SQCourt
//
//  Created by Jack on 14/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController<UIAlertViewDelegate, NSXMLParserDelegate, MBProgressHUDDelegate>
@property(nonatomic, strong) IBOutlet UIImageView *backgroundImage;
@property(nonatomic, strong) IBOutlet UIImageView *logoImage;
@property(nonatomic, strong) IBOutlet UITextField * usernameTextField;
@property(nonatomic, strong) IBOutlet UITextField * passwordTextField;
@property(nonatomic, strong) IBOutlet UIButton *loginBtn;
@property(nonatomic, strong) IBOutlet UIBarButtonItem *cancelBtn;
-(IBAction)dismissThisView;
- (BOOL)login;
- (BOOL)loginMuted;
- (void)alert;
@end
