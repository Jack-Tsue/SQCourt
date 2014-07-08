//
//  ConversationCell.h
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationCell : UITableViewCell
@property (nonatomic,retain) UILabel *nameLabel;
@property (nonatomic,retain) UILabel *contentLabel;
@property BOOL isMine;
-(void)initLayuot;
-(void)setContent:(NSString*)text;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
