//
//  CourtChangeCell.h
//  SQCourt
//
//  Created by Jack on 25/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourtChangeCell : UITableViewCell
@property (nonatomic,retain) UILabel *changeDetailLabel;
@property (nonatomic,retain) UILabel *changeReasonLabel;
@property (nonatomic,retain) UILabel *startDateLabel;
@property (nonatomic,retain) UILabel *endDateLabel;
@property (nonatomic,retain) UILabel *durationLabel;

@property (nonatomic,retain) UILabel *changeDetail;
@property (nonatomic,retain) UILabel *changeReason;
@property (nonatomic,retain) UILabel *startDate;
@property (nonatomic,retain) UILabel *endDate;
@property (nonatomic,retain) UILabel *duration;

-(void)setReasonText:(NSString*)text;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
