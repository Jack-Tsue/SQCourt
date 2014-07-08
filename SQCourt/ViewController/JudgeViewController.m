//
//  JudgeViewController.m
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "JudgeViewController.h"
#import "JudgeSingleton.h"

@interface JudgeViewController ()
@property (nonatomic, strong) UIImageView *localThumbnailView;
@property (nonatomic, retain)  UIScrollView *scrollView;
@property (nonatomic, retain)  UILabel *contentTextView;

@end

@implementation JudgeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentTextView = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 280, 1000)];
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_contentTextView];
    
    _judgeResume = [_judgeResume stringByReplacingOccurrencesOfString:@"【简历】" withString:@"\n\n\n【简历】\n\n"];
    _judgeResume = [_judgeResume stringByReplacingOccurrencesOfString:@"【分工】" withString:@"\n\n\n【分工】\n\n"];
    _contentTextView.text = _judgeResume;
    CGRect frame = [_scrollView frame];
    //文本赋值
    //设置label的最大行数
    _contentTextView.numberOfLines = 0;
    CGSize size = CGSizeMake(280, 10000);
    CGSize labelSize = [_contentTextView.text sizeWithFont:_contentTextView.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    _contentTextView.frame = CGRectMake(_contentTextView.frame.origin.x, _contentTextView.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+350;
    
    [_scrollView setContentSize:frame.size];
    
    self.localThumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-105)/2, 20, 105, 150)];
    
    NSString *imagePath = [[NSString stringWithFormat:@"%@%@", @"http://61.147.251.189/sqzy/resources/fgzp/", _judgePic] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *imageUrl = [NSURL URLWithString:imagePath];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
	self.localThumbnailView.image = image;
	[_scrollView addSubview:self.localThumbnailView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"contactJudge"]) {
        [[JudgeSingleton sharedInstance] setCode:_judgeID];
        [[JudgeSingleton sharedInstance] setName:_judgeName];
//        RatingViewController *destViewController = [segue destinationViewController];
//        destViewController.caseID = caseID;
//        destViewController.caseKey = caseKey;
        //         destViewController.contentTextView = [[UITextView alloc] init];
        //         destViewController.contentTextView.text = p.content;
    }
}

@end
