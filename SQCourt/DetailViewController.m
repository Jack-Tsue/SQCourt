//
//  DetailViewController.m
//  TEST
//
//  Created by Jack on 10/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (nonatomic, strong) UIImageView *localThumbnailView;
@property (nonatomic, strong) URBMediaFocusViewController *mediaFocusController;

@property (nonatomic, retain)  UIScrollView *scrollView;
@property (nonatomic, retain)  UILabel *contentTextView;
@property (nonatomic, retain)  UILabel *dateLabel;
@property (nonatomic, retain)  UILabel *editorLabel;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithProcess:(SQProcess *)p
{
    self.process = p;
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_process.image != nil) {
        [self showPicView];
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)]) {
            self.extendedLayoutIncludesOpaqueBars = YES;
        }
    } else {
        [self showNoPicView];
    }
	// Do any additional setup after loading the view.
}

- (void)showPicView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    _contentTextView = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 1000)];
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_contentTextView];
    
    _contentTextView.text = _process.content;
    
    CGRect frame = [_scrollView frame];
    //文本赋值
    //设置label的最大行数
    _contentTextView.numberOfLines = 0;
    CGSize size = CGSizeMake(280, 10000);
    CGSize labelSize = [_contentTextView.text sizeWithFont:_contentTextView.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    _contentTextView.frame = CGRectMake(_contentTextView.frame.origin.x, _contentTextView.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+200;
    
    [_scrollView setContentSize:frame.size];
    
    self.mediaFocusController = [[URBMediaFocusViewController alloc] init];
	self.mediaFocusController.delegate = self;
    
    self.localThumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 280, 300)];
	self.localThumbnailView.backgroundColor = [UIColor darkGrayColor];
	self.localThumbnailView.contentMode = UIViewContentModeScaleAspectFill;
	self.localThumbnailView.clipsToBounds = YES;
	self.localThumbnailView.userInteractionEnabled = YES;
	self.localThumbnailView.image = [UIImage imageNamed:_process.image];
	[_scrollView addSubview:self.localThumbnailView];
	[self addTapGestureToView:self.localThumbnailView];
    
}

- (void)addTapGestureToView:(UIView *)view {
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFocusView:)];
	tapRecognizer.numberOfTapsRequired = 1;
	tapRecognizer.numberOfTouchesRequired = 1;
	[view addGestureRecognizer:tapRecognizer];
}

- (void)showFocusView:(UITapGestureRecognizer *)gestureRecognizer {
		[self.mediaFocusController showImage:[UIImage imageNamed:_process.image] fromView:self.view];
}

- (void)showNoPicView
{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 260, 20)];
    _dateLabel.textColor = [UIColor grayColor];
    _editorLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 260, 20)];
    _editorLabel.textColor = [UIColor grayColor];
    _contentTextView = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 280, 1000)];
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_dateLabel];
    [_scrollView addSubview:_editorLabel];
    [_scrollView addSubview:_contentTextView];
    
    _contentTextView.text = [_process.content stringByReplacingOccurrencesOfString:@" " withString:@"\n\n"];
    _dateLabel.text = _process.time;
    _editorLabel.text = _process.editor;
    
    CGRect frame = [_scrollView frame];
    //文本赋值
    //设置label的最大行数
    _contentTextView.numberOfLines = 0;
    CGSize size = CGSizeMake(280, 10000);
    CGSize labelSize = [_contentTextView.text sizeWithFont:_contentTextView.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    _contentTextView.frame = CGRectMake(_contentTextView.frame.origin.x, _contentTextView.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    frame.size.height = labelSize.height+300;
    
    [_scrollView setContentSize:frame.size];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
