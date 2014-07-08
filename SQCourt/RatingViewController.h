//
//  RatingViewController.h
//  SQCourt
//
//  Created by Jack on 10/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "MBProgressHUD.h"

@interface RatingViewController : UIViewController<RatingViewDelegate, NSXMLParserDelegate, MBProgressHUDDelegate>
@property (nonatomic, strong) NSString *caseID;
@property (nonatomic, strong) NSString *caseKey;
@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, retain) IBOutlet RatingView *starView1;
@property (nonatomic, retain) IBOutlet RatingView *starView2;
@property (nonatomic, retain) IBOutlet RatingView *starView3;
@property (nonatomic, retain) IBOutlet RatingView *starView4;
@property (nonatomic, retain) IBOutlet RatingView *starView5;
@property (nonatomic, strong) IBOutlet UITextView *commentTextView;
@property (nonatomic, strong) IBOutlet UIButton *submitBtn;
@end
