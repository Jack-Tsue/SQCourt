//
//  CourtArrangeCell.h
//  SQCourt
//
//  Created by Jack on 17/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourtArrangeCell : UITableViewCell
@property (nonatomic,retain) UILabel *arrangeIdLabel;
@property (nonatomic,retain) UILabel *courtDateLabel;
@property (nonatomic,retain) UILabel *courtLocationLabel;

@property (nonatomic,retain) UILabel *arrangeId;
@property (nonatomic,retain) UILabel *courtDate;
@property (nonatomic,retain) UILabel *courtLocation;

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
