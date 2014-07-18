//
//  ChatViewController.m
//  SQCourt
//
//  Created by Jack on 16/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "ChatViewController.h"
#import "Macro.h"
#import "UserSingleton.h"
#import "JudgeSingleton.h"
#import "SQChat.h"
#import "SQConversation.h"
#import "KeychainItemWrapper.h"

@interface ChatViewController () {
    NSMutableArray *messages;
    NSMutableArray *timestamps;
    MBProgressHUD *loadingHud;
    NSString *currentTagName;
    NSMutableString *currentValue;
    BOOL isSuccess;
    UIAlertView *alert;
    NSString *cid;
    
    NSXMLParser *parser_addFghh;
    NSXMLParser *parser_getFghh;
}

@end

@implementation ChatViewController

#pragma mark - Initialization
- (UIButton *)sendButton
{
    // Override to use a custom send button
    // The button's frame is set automatically for you
    return [UIButton defaultSendButton];
}


#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    cid = @"";
    self.delegate = self;
    self.dataSource = self;
    self.navigationController.title = @"消息记录";
    if (isIos7System) {
        [self.tabBarController.tabBar setHidden:YES];
    }
//    CGRect frame = self.tabBarController.view.superview.frame;
//    CGFloat offset = self.tabBarController.tabBar.frame.size.height;
//    frame.size.height += offset;
//    self.tabBarController.view.frame = frame;
    
    messages = [[NSMutableArray alloc] init];
    
    timestamps = [[NSMutableArray alloc] initWithObjects:
                       [NSDate distantPast],
                       [NSDate distantPast],
                       [NSDate distantPast],
                       [NSDate date],
                       nil];
    
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
    //                                                                                           target:self
    //                                                                                           action:@selector(buttonPressed:)];
    
    loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:loadingHud];
    loadingHud.delegate = self;
    loadingHud.labelText = @"载入中……";
    if (_isContactJudge) {
        [loadingHud showWhileExecuting:@selector(loadContactJudge) onTarget:self withObject:nil animated:YES];
    } else {
        [loadingHud showWhileExecuting:@selector(loadContactJudge) onTarget:self withObject:nil animated:YES];
    }
}

- (void)loadContactJudge
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@getFghh.do?yhbh=%@&userid=%@&fydm=321300", INTERFACE_ADDRESS,  _conversation.judgeID, [[UserSingleton sharedInstance] getUserID]]];
    // NSLog(@"url: %@", url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    // NSLog(@"recieved: %@", _xmlContent);
    if (xmlData == nil) {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"发生错误"
                 message:@"连接时发生问题，请稍后再试！"
                 delegate:self
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil, nil];
        [alert show];
    } else {
        NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
        [parser setDelegate:self];
        [parser parse];
        [self loadChat];
    }
}

- (void)loadChat
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@getHhnr.do?hhbh=%@&sffg=Y", INTERFACE_ADDRESS,  cid]];
    // NSLog(@"url: %@", url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    if (xmlData == nil) {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"发生错误"
                 message:@"连接时发生问题，请稍后再试！"
                 delegate:self
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil, nil];
        [alert show];
    } else {
        NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
        [parser setDelegate:self];
        [parser parse];
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messages.count;
}

#pragma mark - Messages view delegate
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@addFghhfy.do?hhbh=%@&fynr=%@&sffg=N", INTERFACE_ADDRESS,  cid,  [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    // NSLog(@"url: %@", url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
//    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
//    // NSLog(@"recieved: %@", _xmlContent);
    if (xmlData == nil) {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"发生错误"
                 message:@"连接时发生问题，请稍后再试！"
                 delegate:self
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [JSMessageSoundEffect playMessageSentSound];
        SQChat *c = [[SQChat alloc] init];
        c.content = text;
        c.isJudge = @"N";
        [messages addObject:c];
    }
    
    [self finishSend];
}

- (JSInputBarStyle)inputBarStyle
{
    /*
     JSInputBarStyleDefault,
     JSInputBarStyleFlat
     */
    return JSInputBarStyleFlat;
}

- (JSBubbleMediaType)messageMediaTypeForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JSBubbleMediaTypeText;
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([((SQChat *)[messages objectAtIndex:indexPath.row]).isJudge isEqualToString:@"Y"]) {
        return JSBubbleMessageTypeIncoming;
    }
    return JSBubbleMessageTypeOutgoing;
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isIos7System) {
        return JSBubbleMessageStyleFlat;
    } else {
        return JSBubbleMessageStyleSquare;
    }
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyCustom;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    return JSMessagesViewAvatarPolicyBoth;
}

- (JSAvatarStyle)avatarStyle
{
    return JSAvatarStyleNone;
}

//  Optional delegate method
//  Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  - (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
//

#pragma mark - Messages view data source
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((SQChat *)[messages objectAtIndex:indexPath.row]).content;
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [timestamps objectAtIndex:indexPath.row];
}

- (UIImage *)avatarImageForIncomingMessage
{
    return [UIImage imageNamed:@"demo-avatar-woz"];
}

- (UIImage *)avatarImageForOutgoingMessage
{
    return [UIImage imageNamed:@"demo-avatar-jobs"];
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
    messages = [[NSMutableArray alloc]init];
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
    if ([currentTagName isEqualToString:@"Hhfy"]) {
        SQChat *c = [[SQChat alloc] init];
        [messages addObject:c];
    } else if ([currentTagName isEqualToString:@"Hhfy"]) {
        
    }
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
    SQChat *chat = [messages lastObject];
    
	if ([currentTagName isEqualToString:@"Hhnrbh"] && chat) {
        [chat setChatID:currentValue];
	}
    if ([currentTagName isEqualToString:@"Fynr"] && chat) {
        [chat setContent:currentValue];
	}
    if ([currentTagName isEqualToString:@"Sffg"] && chat) {
        [chat setIsJudge:currentValue];
	}
    if ([currentTagName isEqualToString:@"Hhbh"] && cid) {
        cid = currentValue;
	}
    currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.processes userInfo:nil];
}
@end
