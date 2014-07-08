//
//  CaseCalculatorViewController.h
//  SQCourt
//
//  Created by Jack on 9/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseCalculatorViewController : UIViewController<UIAlertViewDelegate> {
    int _amount;
}
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UITextField *input;
@property(nonatomic,retain) UILabel *fortuneCase;
@property(nonatomic,retain) IBOutlet UILabel *marriageCase;
@property(nonatomic,retain) IBOutlet UILabel *humanRightsCase;
@property(nonatomic,retain) IBOutlet UILabel *fortuneKeep;
@property(nonatomic,retain) IBOutlet UILabel *executeCase;
@property(nonatomic,retain) IBOutlet UILabel *bankruptCase;
@property(nonatomic,retain) IBOutlet UILabel *payOrder;
@property(nonatomic,retain) IBOutlet UIButton *calculateBtn;
@end
