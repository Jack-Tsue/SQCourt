//
//  CourtArrangeCell.m
//  SQCourt
//
//  Created by Jack on 17/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "CourtArrangeCell.h"
#import "Macro.h"
@implementation CourtArrangeCell


-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}
//初始化控件
-(void)initLayuot{
    _arrangeIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 34, 21)];
    _arrangeIdLabel.textColor = TINTBLUE;
    _arrangeIdLabel.text = @"编号";
    [self addSubview:_arrangeIdLabel];
    
    _courtDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 49, 34, 21)];
    _courtDateLabel.textColor = TINTBLUE;
    _courtDateLabel.text = @"日期";
    [self addSubview:_courtDateLabel];
    
    _courtLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 78, 34, 21)];
    _courtLocationLabel.textColor = TINTBLUE;
    _courtLocationLabel.text = @"地点";
    [self addSubview:_courtLocationLabel];
    
    _arrangeId = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 21)];
    [self addSubview:_arrangeId];
    _courtDate = [[UILabel alloc] initWithFrame:CGRectMake(100, 49, 200, 21)];
    [self addSubview:_courtDate];
    _courtLocation = [[UILabel alloc] initWithFrame:CGRectMake(100, 78, 200, 21)];
    [self addSubview:_courtLocation];
    
    CGRect frame = [self frame];
    frame.size.height = 100;
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
