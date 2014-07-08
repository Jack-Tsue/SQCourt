//
//  ManualTableViewController.h
//  SQCourt
//
//  Created by Jack on 9/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQTopic.h"

@interface ManualTableViewController : UITableViewController <NSXMLParserDelegate>
{
    NSString *currentTagName;
    NSMutableString *currentValue;
}
@property (nonatomic, copy) NSMutableArray *topics;

@end
