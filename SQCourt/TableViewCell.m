//
//  TableViewCell.m
//  AdaptiveCell
//
//  Created by swinglife on 14-1-10.
//  Copyright (c) 2014年 swinglife. All rights reserved.
//

#import "TableViewCell.h"
#import "Macro.h"

@implementation TableViewCell

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}
//初始化控件
-(void)initLayuot{
    _caseNoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 34, 21)];
    _caseNoLabel.textColor = TINTBLUE;
    _caseNoLabel.text = @"编号";
    [self addSubview:_caseNoLabel];
    
    _caseDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 49, 34, 21)];
    _caseDateLabel.textColor = TINTBLUE;
    _caseDateLabel.text = @"日期";
    [self addSubview:_caseDateLabel];
    
    _courtLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 78, 34, 21)];
    _courtLabel.textColor = TINTBLUE;
    _courtLabel.text = @"地点";
    [self addSubview:_courtLabel];
    
    _caseNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 107, 34, 21)];
    _caseNameLabel.textColor = TINTBLUE;
    _caseNameLabel.text = @"详细";
    [self addSubview:_caseNameLabel];
    
    _caseNo = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 240, 21)];
    [self addSubview:_caseNo];
    _caseDate = [[UILabel alloc] initWithFrame:CGRectMake(80, 49, 220, 21)];
    [self addSubview:_caseDate];
    _court = [[UILabel alloc] initWithFrame:CGRectMake(80, 78, 220, 21)];
    [self addSubview:_court];
    _introduction = [[UILabel alloc] initWithFrame:CGRectMake(80, 107, 220, 40)];
    [self addSubview:_introduction];
}

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.introduction.text = text;
    //设置label的最大行数
    self.introduction.numberOfLines = 10;
    CGSize size = CGSizeMake(220, 1000);
    CGSize labelSize = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.introduction.frame = CGRectMake(self.introduction.frame.origin.x, self.introduction.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+110;
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
