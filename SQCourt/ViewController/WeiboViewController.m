//
//  WeiboViewController.m
//  SQCourt
//
//  Created by Jack on 18/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "WeiboViewController.h"
#import "Macro.h"

@interface WeiboViewController () {
    BOOL isLoadingFinished;
    NSURL *url;
}

@end

@implementation WeiboViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        self.view = view;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!_isLoadFromContent) {
        if (_urlPath == nil) {
            url = [NSURL URLWithString:@"http://m.weibo.com/u/3917169306"];
        } else {
            url = [NSURL URLWithString:_urlPath];
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_weiboView loadRequest:request];
    } else {
        isLoadingFinished = NO;
        
        //这里一定要设置为NO
        [_weiboView setScalesPageToFit:NO];
        
        
        url = [NSURL URLWithString:SERVER_ADDRESS];
        [_weiboView loadHTMLString:[self htmlEntityDecode:_content] baseURL:url];
        //第一次加载先隐藏webview
//        [_weiboView setHidden:YES];
//        _weiboView.delegate = self;
    }
    
    	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    string = [string stringByReplacingOccurrencesOfString:@"resize_width=\"600\"" withString:@"width=\"300\""];
    return string;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //若已经加载完成，则显示webView并return
    if(isLoadingFinished)
    {
        [_weiboView setHidden:NO];
        return;
    }
    
    //js获取body宽度
    NSString *bodyWidth= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollWidth "];
    
    int widthOfBody = [bodyWidth intValue];
    
    //获取实际要显示的html
    NSString *html = [self htmlAdjustWithPageWidth:widthOfBody
                                              html:[self htmlEntityDecode:_content]
                                           webView:webView];
    
    //设置为已经加载完成
    isLoadingFinished = YES;
    //加载实际要现实的html
    [_weiboView loadHTMLString:html baseURL:url];
}

//获取宽度已经适配于webView的html。这里的原始html也可以通过js从webView里获取
- (NSString *)htmlAdjustWithPageWidth:(CGFloat )pageWidth
                                 html:(NSString *)html
                              webView:(UIWebView *)webView
{
    NSMutableString *str = [NSMutableString stringWithString:html];
    //计算要缩放的比例
    CGFloat initialScale = webView.frame.size.width/pageWidth;
    //将</head>替换为meta+head
    NSString *stringForReplace = [NSString stringWithFormat:@"<head><meta name=\"viewport\" content=\" initial-scale=%f, minimum-scale=0.1, maximum-scale=2.0, user-scalable=yes\"></head>",initialScale];
    
    NSString *string = [NSString stringWithFormat:@"%@%@", stringForReplace, str];
//    NSRange range =  NSMakeRange(0, str.length);
//    //替换
//    [str replaceOccurrencesOfString:@"</head>" withString:stringForReplace options:NSLiteralSearch range:range];

    return string;
}
@end
