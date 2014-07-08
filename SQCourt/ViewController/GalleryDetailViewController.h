//
//  GalleryDetailViewController.h
//  SQCourt
//
//  Created by Jack on 9/6/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"

@interface GalleryDetailViewController : UIViewController<EScrollerViewDelegate>
@property(nonatomic) int index;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@end
