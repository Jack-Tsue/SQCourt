//
//  AdviceCell.m
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "AdviceCell.h"
#import "Macro.h"

@implementation AdviceCell

-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}
//初始化控件
-(void)initLayuot{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 34, 21)];
    _nameLabel.textColor = TINTBLUE;
    _nameLabel.text = @"姓名";
    [self addSubview:_nameLabel];
    
    _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 49, 34, 21)];
    _phoneLabel.textColor = TINTBLUE;
    _phoneLabel.text = @"电话";
    [self addSubview:_phoneLabel];
    
    _qqLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 78, 34, 21)];
    _qqLabel.textColor = TINTBLUE;
    _qqLabel.text = @"标题";
    [self addSubview:_qqLabel];
    
    
    _adviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 107, 34, 21)];
    _adviceLabel.textColor = TINTBLUE;
    _adviceLabel.text = @"内容";
    [self addSubview:_adviceLabel];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 220, 21)];
    [self addSubview:_name];
    _phone = [[UILabel alloc] initWithFrame:CGRectMake(80, 49, 220, 21)];
    [self addSubview:_phone];
    _qq = [[UILabel alloc] initWithFrame:CGRectMake(80, 78, 220, 21)];
    [self addSubview:_qq];
    _introduction = [[UILabel alloc] initWithFrame:CGRectMake(20, 127, 300, 40)];
    [self addSubview:_introduction];
}

//赋值 and 自动换行,计算出cell的高度
-(void)setIntroductionText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.introduction.text = text;
    //设置label的最大行数
    self.introduction.numberOfLines = 1000;
    CGSize size = CGSizeMake(280, 10000);
    CGSize labelSize = [self.introduction.text sizeWithFont:self.introduction.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.introduction.frame = CGRectMake(self.introduction.frame.origin.x, self.introduction.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+140;
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
