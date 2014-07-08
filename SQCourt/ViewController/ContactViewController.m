//
//  ContactViewController.m
//  SQCourt
//
//  Created by Jack on 20/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "ContactViewController.h"
#import "Macro.h"
#import "UserSingleton.h"
#import "KeychainItemWrapper.h"
#import "LoginViewController.h"
#import "SSKeyChain.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    if ([[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginView"];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navigation animated:NO];
    }
    if ([[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
        [self.navigationController popViewControllerAnimated:YES];  
    } else {
        _logoutBtn = [_logoutBtn initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_scrollView contentSizeToFit];
//    [_scrollView setScrollEnabled:YES];
//    [self.view addSubview:_scrollView];
    //To make the border look very close to a UITextField
        [_commentTextView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor]];
        [_commentTextView.layer setBorderWidth:1.0];
        
        //The rounded corner part, where you specify your view's corner radius:
        _commentTextView.layer.cornerRadius = 5;
        _commentTextView.clipsToBounds = YES;
    
    [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    _hintLabel.text = _hintText;
}

- (void)submit:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if ([[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"尚未登录" message:@"请点击右上角登录按钮登录帐号！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    }else if (_nameTextField.text==nil || _phoneTextField.text==nil || _titleTextField.text==nil || _commentTextView.text==nil) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"有项目为空，请填写";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
    } else {
        loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:loadingHud];
        loadingHud.delegate = self;
        loadingHud.labelText = @"正在提交";
        loadingHud.detailsLabelText = @"提交表单中，请稍候……";
        [loadingHud showWhileExecuting:@selector(postComment) onTarget:self withObject:nil animated:YES];
    }    
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

- (void) postComment
{
    NSString *postStr = [NSString stringWithFormat:@"%@addYjjy.do?xm=%@&lxdh=%@&lxqq=0&bt=%@&yjjynr=%@&fydm=321300&userid=%@&type=%@",INTERFACE_ADDRESS, _nameTextField.text, _phoneTextField.text, _titleTextField.text,  [_commentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""], [[UserSingleton sharedInstance] getUserID], _type];

    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // NSLog(@"post: %@",url);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.processes userInfo:nil];
}

-(void)logout
{
	[SSKeychain deletePasswordForService:kSSServiceName account:[[UserSingleton sharedInstance] getUserName]];
    
    [[UserSingleton sharedInstance] setUserID:@""];
    [[UserSingleton sharedInstance] setCaseID:@""];
    
    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginView"];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentModalViewController:navigation animated:NO];
}

@end
