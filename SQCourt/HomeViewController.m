//
//  HomeViewController.m
//  testScrollViewViewController
//
//  Created by imac  on 13-7-10.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboViewController.h"
#import "Macro.h"
#import "KeychainItemWrapper.h"
#import "UserSingleton.h"
#import "NewsTableViewController.h"
#import "GalleryDetailViewController.h"
#import "AppDelegate.h"
#import "ContactViewController.h"
#import "SSKeychain.h"

@interface HomeViewController () {
    NSMutableArray *picDetails;
    int galleryTimes;
    EScrollerView *scroller;
}

@end

@implementation HomeViewController
- (void)viewDidAppear:(BOOL)animated
{
    if (![[[UserSingleton sharedInstance] getUserID] isEqualToString:@""])
    {
        _logoutBtn = [_logoutBtn initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
        self.navigationItem.RightBarButtonItem = _logoutBtn;
    } else {
        self.navigationItem.RightBarButtonItem = nil; ;
    }
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:TINTBLUE forKey:UITextAttributeTextColor]];
        self.scrollView.frame = CGRectMake(0, 0, 320, 520);
        self.scrollView.contentSize = CGSizeMake(320, 560);
    } else {
        
        self.scrollView.frame = self.view.frame;
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 600);
    }
    [self.scrollView setScrollEnabled:YES];
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    UIImage *galleryImg0 = [UIImage imageNamed:@"gallery1"];
    UIImage *galleryImg1 = [UIImage imageNamed:@"gallery0"];
    UIImage *galleryImg2 = [UIImage imageNamed:@"gallery2"];
    UIImage *galleryImg3 = [UIImage imageNamed:@"gallery3"];
    UIImage *galleryImg4 = [UIImage imageNamed:@"gallery4"];

    [picArray addObject:galleryImg0];
    [picArray addObject:galleryImg1];
    [picArray addObject:galleryImg2];
    [picArray addObject:galleryImg3];
    [picArray addObject:galleryImg4];

    picDetails = [[NSMutableArray alloc] init];

    [picDetails addObject:@"GalleryDetail1"];
    [picDetails addObject:@"GalleryDetail2"];
    [picDetails addObject:@"GalleryDetail3"];
    [picDetails addObject:@"GalleryDetail4"];

    
    CGRect galleryRect;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        galleryRect = CGRectMake(0, 0, 320, 180);
    } else {
        galleryRect = CGRectMake(0, 40, 320, 180);
    }
    scroller =[[EScrollerView alloc] initWithFrameRect:galleryRect ImageArray:[NSArray arrayWithObjects:@"gallery1",@"gallery0",@"gallery2", @"gallery3",@"gallery4", nil] TitleArray:[NSArray arrayWithObjects:@"新闻1",@"新闻2",@"新闻3", @"新闻4", @"新闻5", nil]];
    scroller.delegate = self;
    
    galleryTimes = 0;
    //时间间隔
    NSTimeInterval timeInterval =5.0 ;
    //定时器 repeats 表示是否需要重复，NO为只重复一次
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(moveGallery) userInfo:nil repeats:YES];
    
    [_askBtn addTarget:self action:@selector(askBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_judgementBtn addTarget:self action:@selector(judgementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msgBtn addTarget:self action:@selector(msgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_auctionBtn addTarget:self action:@selector(auctionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:scroller];
    [self.view addSubview:self.scrollView];
}

-(void)logout
{
	[SSKeychain deletePasswordForService:kSSServiceName account:[[UserSingleton sharedInstance] getUserName]];
    
    [[UserSingleton sharedInstance] setUserID:@""];
    [[UserSingleton sharedInstance] setCaseID:@""];
    
    [self viewDidAppear:YES];
}

- (void)askBtnClick:(id)sender
{
    UIStoryboard *storyboard = self.navigationController.storyboard;
    WeiboViewController *askView = [storyboard instantiateViewControllerWithIdentifier:@"judgeDoc"];
    askView.urlPath = @"http://search.chinalaw.gov.cn/search2.html";
    askView.navigationItem.title = @"法律查询";
    [self.navigationController pushViewController:askView animated:YES];
}

- (void)judgementBtnClick:(id)sender
{
    UIStoryboard *storyboard = self.navigationController.storyboard;
    WeiboViewController *askView = [storyboard instantiateViewControllerWithIdentifier:@"judgeDoc"];
    askView.urlPath = @"http://www.sqfycpws.gov.cn/";
    askView.navigationItem.title = @"裁判文书";
    [self.navigationController pushViewController:askView animated:YES];
}

- (void)msgBtnClick:(id)sender
{
    UIStoryboard *storyboard = self.navigationController.storyboard;
    ContactViewController *destVC = [storyboard instantiateViewControllerWithIdentifier:@"contact"];
    destVC.type = @"4";
    destVC.title = @"院长留言";
    destVC.hintText=@"说明：社会公众可以在此对院长留言。您的留言内容和我们的回复内容，您能在消息记录中看到。";
    [self.navigationController pushViewController:destVC animated:YES];
}

- (void)auctionBtnClick:(id)sender
{
    UIStoryboard *storyboard = self.navigationController.storyboard;
    WeiboViewController *askView = [storyboard instantiateViewControllerWithIdentifier:@"judgeDoc"];
    askView.urlPath = @"http://sf.taobao.com/law_court.htm?spm=5262.7119837.0.0.yexpD5&user_id=1925542276";
    askView.navigationItem.title = @"司法拍卖";
    [self.navigationController pushViewController:askView animated:YES];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CycleScrollViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    index-=1;
    /*
    if (index != 0) {
        UIStoryboard *storyboard = self.navigationController.storyboard;
        GalleryDetailViewController *gdvc = [storyboard instantiateViewControllerWithIdentifier:(NSString *)[picDetails objectAtIndex:index-1]];
        [self.navigationController pushViewController:gdvc animated:YES];
    }
     */
    UIStoryboard *storyboard = self.navigationController.storyboard;
    GalleryDetailViewController *gdvc = [storyboard instantiateViewControllerWithIdentifier:@"GalleryDetail"];
    gdvc.index = index;
    gdvc.navigationItem.title = @"宿迁市中级人民法院";
    [self.navigationController pushViewController:gdvc animated:YES];
}

-(void)EScrollerViewDidAtIndex:(NSUInteger)index
{
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showNews"]) {
        NewsTableViewController *destViewController = [segue destinationViewController];

        destViewController.category = @"getNews.do";
        destViewController.title = @"法院要闻";
    } else if ([segue.identifier isEqualToString:@"showGgsd"]) {
        NewsTableViewController *destViewController = [segue destinationViewController];

        destViewController.category = @"getGgsd.do";
        destViewController.title = @"公告送达";
    } else if ([segue.identifier isEqualToString:@"showZxpg"]) {
        NewsTableViewController *destViewController = [segue destinationViewController];
        destViewController.title = @"执行曝光";
        destViewController.category = @"getZxbg.do";
    } else if ([segue.identifier isEqualToString:@"showDxal"]) {
        NewsTableViewController *destViewController = [segue destinationViewController];
        destViewController.title = @"典型案例";
        destViewController.category = @"getDxal.do";
    } else if ([segue.identifier isEqualToString:@"showJxjs"]) {
        NewsTableViewController *destViewController = [segue destinationViewController];
        destViewController.title = @"减刑假释";
        destViewController.category = @"getJxjs.do";
    }
    //         destViewController.contentTextView = [[UITextView alloc] init];
    //         destViewController.contentTextView.text = p.content;
    
}

- (void)moveGallery
{
    galleryTimes++;
    [scroller naviToPage:(galleryTimes%5)];
}
@end
