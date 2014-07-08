//
//  LoginViewController.m
//  SQCourt
//
//  Created by Jack on 14/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "LoginViewController.h"
#import "UIButton+Bootstrap.h"
#import "Macro.h"
#import "SSKeychain.h"
#import "JudgeSingleton.h"
#import "RegisterViewController.h"
#import "UserSingleton.h"
#import "SQChatListViewController.h"
#import "AppDelegate.h"

@interface LoginViewController (){
    MBProgressHUD *loadingHud;
    UIAlertView *errorAlert;
    NSString *currentTagName;
    NSMutableString *currentValue;
    NSString *username;
    NSString *password;
    BOOL isLoggedIn;
}

@end

@implementation LoginViewController

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
    username = @"";
    password = @"";

    NSArray *accounts = [SSKeychain accountsForService:kSSServiceName];
    for (NSDictionary *dictionary in accounts) {
        NSLog(@"%@", dictionary);
        username = [dictionary objectForKey:@"acct"];
        password = [SSKeychain passwordForService:kSSServiceName account:username];
	}

//    if (!([username isEqualToString:@""] && [password isEqualToString:@""])) {
//        [self login];
//    }

    if ([self login]) {
    }
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self.view addSubview:_backgroundImage];
    [self.view sendSubviewToBack:_backgroundImage];
    
    if (isIos7System) {
        [_loginBtn primaryStyle];
    } else {
//        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_loginBtn.titleLabel setBackgroundColor:[UIColor clearColor]];
//        [_loginBtn.titleLabel setTextColor:[UIColor redColor]];
//        [_loginBtn setBackgroundImage:[self createImageWithColor:[UIColor blueColor]]  forState:UIControlStateNormal];
//        _loginBtn.backgroundColor = [UIColor blackColor];
        [_loginBtn primaryStyle];

    }
    
    UIImageView *userTintImgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tint_user"]];
    _usernameTextField.rightView=userTintImgv;
    _usernameTextField.rightViewMode = UITextFieldViewModeAlways;
    
    UIImageView *pswdTintImgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tint_lock"]];
    _passwordTextField.rightView=pswdTintImgv;
    _passwordTextField.rightViewMode = UITextFieldViewModeAlways;
    
    CALayer *layer=[_logoImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:10.0];
    [layer setBorderWidth:2];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [_loginBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];

}

-(IBAction)dismissThisView
{
    AppDelegate *thisAppDelegate = [[UIApplication sharedApplication] delegate];
    [(UITabBarController *)thisAppDelegate.window.rootViewController setSelectedIndex:0];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)submit:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    username = _usernameTextField.text;
    password = _passwordTextField.text;
//    loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:loadingHud];
//    loadingHud.delegate = self;
//    loadingHud.labelText = @"正在提交";
//    loadingHud.detailsLabelText = @"提交表单中，请稍候……";
    if (username&&password) {
        [self login];
//        [loadingHud showWhileExecuting:@selector(login) onTarget:self withObject:nil animated:YES];
    } else {
        [self alert];
    }
}

- (void)alert
{
    errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请检查是否有未填写的项！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [errorAlert show];

}
- (BOOL)login
{
    isLoggedIn = NO;
    
    NSString *postStr = [NSString stringWithFormat:@"%@userlogin.do?username=%@&password=%@", INTERFACE_ADDRESS,username, password];
    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@",url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];

    NSLog(@"recieved: %@", _xmlContent);
    
    
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    
    [parser setDelegate:self];
    [parser parse];
    
    
    if (!isLoggedIn) {
        if (![username isEqualToString:@""]) {
            errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名或密码错误，请重新登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [errorAlert show];
        }
        
    } else {
        [SSKeychain setPassword:password forService:kSSServiceName account:username];
        // navigate to chat list
        [self dismissViewControllerAnimated:YES completion:^{
            [(UINavigationController *)self.presentingViewController popToRootViewControllerAnimated:YES];
        }];
    }
    return isLoggedIn;
}

- (BOOL)loginMuted
{
    isLoggedIn = NO;
    username = @"";
    password = @"";
    
    NSArray *accounts = [SSKeychain accountsForService:kSSServiceName];
    for (NSDictionary *dictionary in accounts) {
        NSLog(@"%@", dictionary);
        username = [dictionary objectForKey:@"acct"];
	}

    NSString *postStr = [NSString stringWithFormat:@"%@userlogin.do?username=%@&password=%@", INTERFACE_ADDRESS,username, password];
    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"url: %@",url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    
    NSLog(@"recieved: %@", _xmlContent);
    
    
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    
    [parser setDelegate:self];
    [parser parse];
    
    
    if (!isLoggedIn) {
    } else {
        self.navigationController.title = @"消息记录";
        [SSKeychain setPassword:password forService:kSSServiceName account:username];
        // navigate to chat list
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }
    
    return isLoggedIn;
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"register"]) {
        RegisterViewController *destViewController = [segue destinationViewController];
        destViewController.title = @"注册";
    }
}


#pragma mark - NSXMLParser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    isLoggedIn = YES;
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
    string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //替换回车符和空格
    
    if ([string isEqualToString:@""]) {
        return;
    }
    
    [currentValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
	if ([currentTagName isEqualToString:@"error"]) {
        isLoggedIn = NO;
	}
    if ([currentTagName isEqualToString:@"userid"]) {
        [[UserSingleton sharedInstance] setUserID:currentValue];
    }
    if ([currentTagName isEqualToString:@"username"]) {
        [[UserSingleton sharedInstance] setUserName:currentValue];
    }
    if ([currentTagName isEqualToString:@"phone"]) {
        [[UserSingleton sharedInstance] setPhone:currentValue];
    }
    if ([currentTagName isEqualToString:@"name"]) {
        [[UserSingleton sharedInstance] setName:currentValue];
    }
    currentTagName = nil;
}

- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
