//
//  ContactViewController.h
//  SQCourt
//
//  Created by Jack on 20/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class TPKeyboardAvoidingScrollView;

@interface ContactViewController : UIViewController<MBProgressHUDDelegate, NSXMLParserDelegate, UIAlertViewDelegate> {
    MBProgressHUD *loadingHud;
    NSString *currentTagName;
    NSMutableString *currentValue;
    BOOL isSuccess;
    UIAlertView *alert;
}
@property (nonatomic, strong) IBOutlet UITextField *phoneTextField;
@property (nonatomic, strong) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextView *commentTextView;
@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIButton *submitBtn;
@property (strong, retain) IBOutlet UIBarButtonItem *logoutBtn;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) IBOutlet UILabel *hintLabel;
@property (nonatomic, strong) NSString *hintText;
@end
