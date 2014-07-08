//
//  AutosizeCell.h
//  SQCourt
//
//  Created by Jack on 1/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutosizeCell : UITableViewCell
@property(nonatomic,retain) IBOutlet UILabel *titleLabel;
-(void)setTitle:(NSString*)text;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
