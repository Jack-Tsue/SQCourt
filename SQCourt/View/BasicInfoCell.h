//
//  BasicInfoCell.h
//  SQCourt
//
//  Created by Jack on 18/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoCell : UITableViewCell
@property (nonatomic,retain) UILabel *title;
@property(nonatomic,retain) UILabel *detail;
-(void)setDetailText:(NSString*)text;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
