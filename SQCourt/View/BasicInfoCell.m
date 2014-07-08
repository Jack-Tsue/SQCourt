//
//  BasicInfoCell.m
//  SQCourt
//
//  Created by Jack on 18/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "BasicInfoCell.h"
#import "Macro.h"

@implementation BasicInfoCell
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initLayuot];
    }
    return self;
}
//初始化控件
-(void)initLayuot{
    _title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 300, 21)];
    _title.textColor = TINTBLUE;
    [self addSubview:_title];
    
    
    _detail = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 300, 40)];
    [self addSubview:_detail];
}

//赋值 and 自动换行,计算出cell的高度
-(void)setDetailText:(NSString*)text{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    _detail.text = text;
    //设置label的最大行数
    _detail.numberOfLines = 1000;
    CGSize size = CGSizeMake(280, 10000);
    CGSize labelSize = [_detail.text sizeWithFont:_detail.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    _detail.frame = CGRectMake(_detail.frame.origin.x, _detail.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+40;
    
    self.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
