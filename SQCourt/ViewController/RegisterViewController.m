//
//  RegisterViewController.m
//  SQCourt
//
//  Created by Jack on 14/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIButton+Bootstrap.h"
#import "Macro.h"

@interface RegisterViewController () {
    UIAlertView *errorAlert;
    NSString *currentTagName;
    NSMutableString *currentValue;
    NSString *username;
    NSString *password;
    NSString *name;
    NSString *phone;
    MBProgressHUD *loadingHud;
    BOOL isSuccess;
    NSString *errorMessage;
}

@end

@implementation RegisterViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    [_registerBtn primaryStyle];
    
    [_registerBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}


- (void)submit:(id)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    username = _usernameTextField.text;
    password = _passwordTextField.text;
    phone = _phoneTextField.text;
    name = _nameTextField.text;
    
    if ((![username isEqualToString:@""])&&(![password isEqualToString:@""])&&(![phone isEqualToString:@""])&&(![name isEqualToString:@""])) {
        loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:loadingHud];
        loadingHud.delegate = self;
        loadingHud.labelText = @"正在提交";
        loadingHud.detailsLabelText = @"提交表单中，请稍候……";
        [loadingHud showWhileExecuting:@selector(registerAccount) onTarget:self withObject:nil animated:YES];
 
    } else {
        errorMessage = @"请检查是否有未填写的注册项";
        errorAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [errorAlert show];
    }
    
}

- (void)registerAccount{
    NSString *postStr = [NSString stringWithFormat:@"%@userregister.do?username=%@&password=%@&phone=%@&name=%@", INTERFACE_ADDRESS,username, password, phone, name];
    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // NSLog(@"url: %@",url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    // NSLog(@"recieved: %@", _xmlContent);
    if (xmlData!=nil) {
        NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
        
        [parser setDelegate:self];
        [parser parse];
    } else {
        errorMessage = @"网络异常，请稍后再试！";
    }
    
    errorAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [errorAlert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    isSuccess = YES;
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
        isSuccess = NO;
        if ([currentValue isEqualToString:@"UserAlreadyExist"]) {
            errorMessage = @"该用户名已被注册！请换一个。";
        } else if ([currentValue isEqualToString:@"Parameter Not Complete"]) {
            errorMessage = @"有未填写的信息项！请检查。";
        } else {
            errorMessage = @"注册成功！请返回登录界面登录。";
        }
	}
    currentTagName = nil;
}

@end
