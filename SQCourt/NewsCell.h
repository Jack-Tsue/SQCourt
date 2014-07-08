//
//  NewsCell.h
//  SQCourt
//
//  Created by Jack on 4/7/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell
@property(nonatomic,retain) IBOutlet UILabel *titleLabel;
@property(nonatomic,retain) IBOutlet UILabel *dateLabel;
-(void)setTitle:(NSString*)text;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end