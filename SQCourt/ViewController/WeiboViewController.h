//
//  WeiboViewController.h
//  SQCourt
//
//  Created by Jack on 18/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) IBOutlet UIWebView *weiboView;
@property (nonatomic, strong) NSString *urlPath;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) BOOL isLoadFromContent;
@end
