//
//  SearchResultViewController.h
//  SQCourt
//
//  Created by Jack on 25/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SQSearchResult.h"
#import "SQCourtArrange.h"
#import "SQCourtChange.h"

@interface SearchResultViewController : UITableViewController<MBProgressHUDDelegate, UITableViewDelegate>{
    BOOL didFinishParse;
    NSString *caseID;
    NSString *caseKey;
    SQSearchResult *searchResult;
    NSMutableArray *courtArranges;
    NSMutableArray *courtChanges;
    NSMutableArray *resultSet;
    MBProgressHUD *HUD;
    MBProgressHUD *errHud;

}

- (void)setKey:(NSString *)key withCaseYear:(NSString *)caseYear withCaseNo:(NSString *)caseNo;

@end
