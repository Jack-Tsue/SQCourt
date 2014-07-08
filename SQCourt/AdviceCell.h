//
//  AdviceCell.h
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceCell : UITableViewCell
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *phoneLabel;
@property (nonatomic,retain) UILabel *qqLabel;
@property (nonatomic,retain) UILabel *adviceLabel;

@property (nonatomic,retain) UILabel *name;
@property (nonatomic,retain) UILabel *phone;
@property (nonatomic,retain) UILabel *qq;
//介绍
@property(nonatomic,retain) UILabel *introduction;
//给介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
