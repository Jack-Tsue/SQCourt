//
//  NewsTableViewController.h
//  SQCourt
//
//  Created by Jack on 1/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController<NSXMLParserDelegate>
{
    NSString *currentTagName;
    NSMutableString *currentValue;
}
@property (nonatomic, copy) NSMutableArray *newsArray;
@property (nonatomic, strong) NSString *category;
@end
