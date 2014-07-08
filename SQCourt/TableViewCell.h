#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell{
    
}
@property (nonatomic,retain) UILabel *caseNoLabel;
@property (nonatomic,retain) UILabel *caseDateLabel;
@property (nonatomic,retain) UILabel *courtLabel;
@property (nonatomic,retain) UILabel *caseNameLabel;

@property (nonatomic,retain) UILabel *caseNo;
@property (nonatomic,retain) UILabel *caseDate;
@property (nonatomic,retain) UILabel *court;
//介绍
@property(nonatomic,retain) UILabel *introduction;
//给介绍赋值并且实现自动换行
-(void)setIntroductionText:(NSString*)text;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end