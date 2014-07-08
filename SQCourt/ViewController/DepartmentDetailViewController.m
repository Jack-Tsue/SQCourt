//
//  DepartmentDetailViewController.m
//  SQCourt
//
//  Created by Jack on 11/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "DepartmentDetailViewController.h"
#import "Macro.h"

@interface DepartmentDetailViewController ()

@property (nonatomic, retain)  UIScrollView *scrollView;
@property (nonatomic, retain)  UILabel *contentTextView;
@end

@implementation DepartmentDetailViewController

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
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT)];
    } else {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    }
    _contentTextView = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 1000)];
    
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_contentTextView];
    
    _contentTextView.text = [_content stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n\t"];
    
    CGRect frame = [_scrollView frame];
    //文本赋值
    //设置label的最大行数
    _contentTextView.numberOfLines = 0;
    CGSize size = CGSizeMake(280, 10000);
    CGSize labelSize = [_contentTextView.text sizeWithFont:_contentTextView.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    _contentTextView.frame = CGRectMake(_contentTextView.frame.origin.x, _contentTextView.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+100;
    
    [_scrollView setContentSize:frame.size];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
