//
//  SearchResult.h
//  SQCourt
//
//  Created by Jack on 17/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQCourtArrange.h"

@interface SQSearchResult : NSObject
@property (nonatomic, copy) NSString *caseNo;
@property (nonatomic, copy) NSString *caseName;
@property (nonatomic, copy) NSString *court;
@property (nonatomic, copy) NSString *contractorSector;
@property (nonatomic, copy) NSString *contractor;
@property (nonatomic, copy) NSString *caseReason;
@property (nonatomic, copy) NSString *presidingJudge;
@property (nonatomic, copy) NSString *clerk;
@property (nonatomic, copy) NSString *fullCourtMember;
@property (nonatomic, copy) NSString *caseStatus;
@property (nonatomic, copy) NSString *filingDate;
@property (nonatomic, copy) NSString *caseClosedDate;
@property (nonatomic, copy) NSString *jurisdictionLimit;
@end
