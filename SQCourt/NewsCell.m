//
//  NewsCell.m
//  SQCourt
//
//  Created by Jack on 4/7/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}

-(void)initLayuot{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 267, 20)];
    [self addSubview:_titleLabel];
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 240, 20)];
    [self addSubview:_dateLabel];
}

-(void)setTitle:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.titleLabel.text = text;
    //设置label的最大行数
    self.titleLabel.numberOfLines = 10;
    CGSize size = CGSizeMake(267, 1000);
    CGSize labelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, labelSize.width, labelSize.height);
    
    self.dateLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y + labelSize.height +5, 280, 20);
    //计算出自适应的高度
    frame.size.height = labelSize.height+self.dateLabel.frame.size.height + 20;
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
