//
//  RegisterViewController.h
//  SQCourt
//
//  Created by Jack on 14/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RegisterViewController : UITableViewController<UIAlertViewDelegate, NSXMLParserDelegate, MBProgressHUDDelegate>
@property(nonatomic, strong) IBOutlet UITextField * usernameTextField;
@property(nonatomic, strong) IBOutlet UITextField * passwordTextField;
@property(nonatomic, strong) IBOutlet UITextField * password2TextField;
@property(nonatomic, strong) IBOutlet UITextField * phoneTextField;
@property(nonatomic, strong) IBOutlet UITextField * nameTextField;
@property(nonatomic, strong) IBOutlet UIButton *registerBtn;
@end
