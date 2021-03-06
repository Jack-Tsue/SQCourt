//
//  NewConversationViewController.m
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "NewConversationViewController.h"
#import "JudgeSingleton.h"
#import "UUIDHelper.h"

@interface NewConversationViewController () {
    MBProgressHUD *loadingHud;
    NSString *currentTagName;
    NSMutableString *currentValue;
    BOOL isSuccess;
    UIAlertView *alert;
}

@end

@implementation NewConversationViewController

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
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [_createBtn addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_nameTextField resignFirstResponder];
    [_phoneTextField resignFirstResponder];
}

- (void)create:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
    if ([_nameTextField.text isEqual:@""] || [_phoneTextField.text isEqual:@""]) {
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
        loadingHud.labelText = @"正在创建";
        loadingHud.detailsLabelText = @"提交表单中，请稍候……";
        [loadingHud showWhileExecuting:@selector(createConversation) onTarget:self withObject:nil animated:YES];
    }
}

- (void)createConversation
{
    NSString *postStr = [NSString stringWithFormat:@"http://61.147.251.189/minterface/addFghh.do?fydm=321300&yhbh=%@&xm=%@&imei=%@&lxdh=%@", [[JudgeSingleton sharedInstance] getCode], _nameTextField.text, [UUIDHelper generateUUID], _phoneTextField.text];
    
    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
        alert = [[UIAlertView alloc] initWithTitle:@"创建成功" message:@"请返回上一页，进入对话！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"创建失败" message:@"请确认您之前是否己经向该法官提交过您的姓名及电话。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
@end
