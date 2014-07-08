//
//  HomeViewController.h
//  testScrollViewViewController
//
//  Created by imac  on 13-7-10.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"

@interface HomeViewController : UIViewController<EScrollerViewDelegate, UIAlertViewDelegate>
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIButton *askBtn;
@property(nonatomic,retain) IBOutlet UIButton *judgementBtn;
@property(nonatomic,retain) IBOutlet UIButton *auctionBtn;
@property(strong, retain) IBOutlet UIBarButtonItem *logoutBtn;
@property(strong, retain) IBOutlet UIButton *msgBtn;
@end
