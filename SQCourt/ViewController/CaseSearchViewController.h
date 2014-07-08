//
//  CaseSearchViewController.h
//  SQCourt
//
//  Created by Jack on 25/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseSearchViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextField *caseYearTextField;
@property (nonatomic, strong) IBOutlet UITextField *caseNoTextField;
@property (nonatomic, strong) IBOutlet UITextField *searchKeyTextField;
@property (nonatomic, strong) IBOutlet UIButton *clearBtn;
@property (nonatomic, strong) IBOutlet UIButton *searchBtn;
@end
