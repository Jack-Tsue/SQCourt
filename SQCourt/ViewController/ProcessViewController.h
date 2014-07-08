//
//  ProcessViewController.h
//  TEST
//
//  Created by Jack on 9/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessViewController : UITableViewController
{
    NSString *currentTagName;
    NSMutableString *currentValue;
}
@property (nonatomic, copy) NSMutableArray *processes;
@end
