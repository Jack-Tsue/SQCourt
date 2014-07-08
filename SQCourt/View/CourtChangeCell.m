//
//  CourtChangeCell.m
//  SQCourt
//
//  Created by Jack on 25/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "CourtChangeCell.h"
#import "Macro.h"

@implementation CourtChangeCell

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}
//初始化控件
-(void)initLayuot{
    _changeDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 70, 21)];
    _changeDetailLabel.textColor = TINTBLUE;
    _changeDetailLabel.text = @"变更情况";
    [self addSubview:_changeDetailLabel];
    
    _changeReasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 136, 60, 21)];
    _changeReasonLabel.textColor = TINTBLUE;
    _changeReasonLabel.text = @"原因";
    [self addSubview:_changeReasonLabel];
    
    _startDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 49, 70, 21)];
    _startDateLabel.textColor = TINTBLUE;
    _startDateLabel.text = @"开始时间";
    [self addSubview:_startDateLabel];
    
    _endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 78, 70, 21)];
    _endDateLabel.textColor = TINTBLUE;
    _endDateLabel.text = @"结束时间";
    [self addSubview:_endDateLabel];
    
    _durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 107, 70, 21)];
    _durationLabel.textColor = TINTBLUE;
    _durationLabel.text = @"天数";
    [self addSubview:_durationLabel];
    
    _changeDetail = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 21)];
    [self addSubview:_changeDetail];
    _changeReason = [[UILabel alloc] initWithFrame:CGRectMake(100, 136, 200, 21)];
    [self addSubview:_changeReason];
    _startDate = [[UILabel alloc] initWithFrame:CGRectMake(100, 49, 200, 21)];
    [self addSubview:_startDate];
    _endDate = [[UILabel alloc] initWithFrame:CGRectMake(100, 78, 200, 21)];
    [self addSubview:_endDate];
    _duration = [[UILabel alloc] initWithFrame:CGRectMake(100, 107, 200, 21)];
    [self addSubview:_duration];
    
    CGRect frame = [self frame];
    frame.size.height = 160;
    self.frame = frame;
}


//赋值 and 自动换行,计算出cell的高度
-(void)setReasonText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    _changeReason.text = text;
    //设置label的最大行数
    _changeReason.numberOfLines = 4;
    CGSize size = CGSizeMake(220, 100);
    CGSize labelSize = [_changeReason.text sizeWithFont:_changeReason.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    _changeReason.frame = CGRectMake(_changeReason.frame.origin.x, _changeReason.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+130;
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
