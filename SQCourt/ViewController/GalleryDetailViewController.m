//
//  GalleryDetailViewController.m
//  SQCourt
//
//  Created by Jack on 9/6/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "GalleryDetailViewController.h"
#import "Macro.h"

@interface GalleryDetailViewController ()

@end

@implementation GalleryDetailViewController

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
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:TINTBLUE forKey:UITextAttributeTextColor]];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, 320, 500)];
        self.scrollView.contentSize = CGSizeMake(320, 500);
    } else {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 500);
    }
    [self.scrollView setScrollEnabled:YES];
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    UIImage *galleryImg0 = [UIImage imageNamed:@"detail0"];
    UIImage *galleryImg1 = [UIImage imageNamed:@"detail11"];
    UIImage *galleryImg2 = [UIImage imageNamed:@"detail2"];
    UIImage *galleryImg3 = [UIImage imageNamed:@"detail3"];
    UIImage *galleryImg4 = [UIImage imageNamed:@"detail4"];
    
    [picArray addObject:galleryImg0];
    [picArray addObject:galleryImg1];
    [picArray addObject:galleryImg2];
    [picArray addObject:galleryImg3];
    [picArray addObject:galleryImg4];
    
    CGRect galleryRect;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        galleryRect = CGRectMake(0, 0, 320, 360);
    } else {
        galleryRect = CGRectMake(0, 0, 320, 360);
    }
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:galleryRect ImageArray:[NSArray arrayWithObjects:@"detail0",@"detail11",@"detail2", @"detail3",@"detail4", nil] TitleArray:[NSArray arrayWithObjects:@"新闻1",@"新闻2",@"新闻3", @"新闻4", @"新闻5", nil]];
    scroller.delegate = self;
    [scroller naviToPage:_index];
    [self.scrollView setScrollEnabled:NO];
    [self.scrollView addSubview:scroller];
    [self.view addSubview:self.scrollView];
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

#pragma mark - CycleScrollViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    
}

-(void)EScrollerViewDidAtIndex:(NSUInteger)index
{
}
@end
