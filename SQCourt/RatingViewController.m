//
//  RatingViewController.m
//  SQCourt
//
//  Created by Jack on 10/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "RatingViewController.h"

@interface RatingViewController (){
    int rating1, rating2, rating3, rating4, rating5;
    MBProgressHUD *loadingHud;
    NSString *currentTagName;
    NSMutableString *currentValue;
    BOOL isSuccess;
    UIAlertView *alert;
    NSString *commentStr;
}

@end

@implementation RatingViewController

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
    [_scrollView contentSizeToFit];
    //To make the border look very close to a UITextField
        [_commentTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor]];
        [_commentTextView.layer setBorderWidth:1.0];
        
        //The rounded corner part, where you specify your view's corner radius:
        _commentTextView.layer.cornerRadius = 5;
        _commentTextView.clipsToBounds = YES;
    
    [_starView1 setImagesDeselected:@"star0.png" partlySelected:@"star1.png"fullSelected:@"star2.png" andDelegate:self];
    [_starView1 setRatingViewIdentity:1];
	[_starView1 displayRating:0];
    
    [_starView2 setImagesDeselected:@"star0.png" partlySelected:@"star1.png"fullSelected:@"star2.png" andDelegate:self];
    [_starView2 setRatingViewIdentity:2];
	[_starView2 displayRating:0];
    
    [_starView3 setImagesDeselected:@"star0.png" partlySelected:@"star1.png"fullSelected:@"star2.png" andDelegate:self];
    [_starView3 setRatingViewIdentity:3];
	[_starView3 displayRating:0];
    
    [_starView4 setImagesDeselected:@"star0.png" partlySelected:@"star1.png"fullSelected:@"star2.png" andDelegate:self];
	[_starView4 setRatingViewIdentity:4];
    [_starView4 displayRating:0];
    
    [_starView5 setImagesDeselected:@"star0.png" partlySelected:@"star1.png"fullSelected:@"star2.png" andDelegate:self];
	[_starView5 setRatingViewIdentity:5];
    [_starView5 displayRating:0];
    _commentTextView.text=@" ";
    
    [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set determinate mode
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.mode = MBProgressHUDModeDeterminate;
	HUD.delegate = self;
	HUD.labelText = @"载入中...";
	[HUD showWhileExecuting:@selector(loadComment) onTarget:self withObject:nil animated:YES];
}

- (void)loadComment
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://61.147.251.189/minterface/getPj.do?ajcxm=%@", _caseKey]];
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser parse];
    // NSLog(@"HEHE %@", commentStr);
    dispatch_async(dispatch_get_main_queue(), ^{
        _commentTextView.text = commentStr;
    });
}

-(void)ratingChanged:(float)newRating withIdentity:(int)ratingViewID{
    switch (ratingViewID) {
        case 1:
            rating1=newRating;
            break;
        case 2:
            rating2=newRating;
            break;
        case 3:
            rating3=newRating;
            break;
        case 4:
            rating4=newRating;
            break;
        case 5:
            rating5=newRating;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submit:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    if ((rating1<4||rating2<4||rating3<4||rating4<4||rating5<4)&&[_commentTextView.text isEqualToString:@" "])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您有三星或以下评价，请说明情况！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }
    
    loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:loadingHud];
    loadingHud.delegate = self;
    loadingHud.labelText = @"正在提交";
    loadingHud.detailsLabelText = @"提交表单中，请稍候……";
    [loadingHud showWhileExecuting:@selector(postComment) onTarget:self withObject:nil animated:YES];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

- (void) postComment
{
    NSString *postStr = [NSString stringWithFormat:@"http://61.147.251.189/minterface/addPj.do?ajcxm=%@&ajmc=%@&fydm=321300&pjdj1=%d&pjdj2=%d&pjdj3=%d&pjdj4=%d&pjdj5=%d5&pjnr=%@", _caseKey, @"0", rating1,rating2, rating3,rating4,rating5, [_commentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // NSLog(@"post url: %@",postStr);
    // NSLog(@"url: %@",url);

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
    NSString *str = @"type=focus-c";//设置参数
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *receivedStr = [[NSString alloc]initWithData:receivedData encoding:NSUTF8StringEncoding];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[receivedStr dataUsingEncoding:NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser parse];
    
    // NSLog(@"received: %@",receivedStr);
    
    if (isSuccess) {
        alert = [[UIAlertView alloc] initWithTitle:@"发送成功" message:@"我们将尽快与您联系！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"发送失败" message:@"请稍后再试！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }
    
    [alert setBackgroundColor:[UIColor blueColor]];
    
    [alert setContentMode:UIViewContentModeScaleAspectFit];
    
    [alert show];
}


#pragma mark - NSXMLParser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    isSuccess = NO;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError

{
    // NSLog(@"%@",parseError);
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if (currentValue !=nil ){
        currentValue = nil;
    }
    
    currentValue = [[NSMutableString alloc] init];
    currentTagName = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //    string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //替换回车符和空格
    
    if ([string isEqualToString:@""]) {
        return;
    }
    
    [currentValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
	if ([currentTagName isEqualToString:@"is_success"]) {
        if ([currentValue isEqualToString:@"T"]) {
            isSuccess = YES;
        }
	}
    if ([currentTagName isEqualToString:@"Pjdj1"]) {
        [_starView1 displayRating:[currentValue floatValue]];
	}
    if ([currentTagName isEqualToString:@"Pjdj2"]) {
        [_starView2 displayRating:[currentValue floatValue]];
	}
    if ([currentTagName isEqualToString:@"Pjdj3"]) {
        [_starView3 displayRating:[currentValue floatValue]];
	}
    if ([currentTagName isEqualToString:@"Pjdj4"]) {
        [_starView4 displayRating:[currentValue floatValue]];
	}
    if ([currentTagName isEqualToString:@"Pjdj5"]) {
        [_starView5 displayRating:[currentValue floatValue]];
	}
    if ([currentTagName isEqualToString:@"Pjnr"]) {
        commentStr=currentValue;
	}
    
    currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.processes userInfo:nil];
}


@end
