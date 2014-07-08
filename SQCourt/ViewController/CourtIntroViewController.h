//
//  CourtIntroViewController.h
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourtIntroViewController : UIViewController
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIImageView *localThumbnailView;
@property (nonatomic, retain) IBOutlet UILabel *contentTextView;
@end
