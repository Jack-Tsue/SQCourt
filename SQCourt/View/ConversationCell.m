//
//  ConversationCell.m
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "ConversationCell.h"
#import "Macro.h"

@implementation ConversationCell

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}

-(void)initLayuot{
    if (_isMine) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 240, 20)];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 240, 100)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 240, 20)];
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 240, 100)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    _nameLabel.textColor = TINTBLUE;
    [self addSubview:_nameLabel];
    [self addSubview:_contentLabel];
}

-(void)setContent:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.contentLabel.text = text;
    //设置label的最大行数
    self.contentLabel.numberOfLines = 10;
    CGSize size = CGSizeMake(240, 1000);
    CGSize labelSize = [self.contentLabel.text sizeWithFont:self.contentLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.contentLabel.frame = CGRectMake(self.contentLabel.frame.origin.x, self.contentLabel.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+45;
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
