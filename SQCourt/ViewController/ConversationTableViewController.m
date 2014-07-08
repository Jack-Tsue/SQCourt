//
//  ConversationTableViewController.m
//  SQCourt
//
//  Created by Jack on 22/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "ConversationTableViewController.h"
#import "JudgeSingleton.h"
#import "UUIDHelper.h"
#import "Macro.h"
#import "SendConversationViewController.h"
#import "SQChat.h"
#import "ConversationCell.h"

@interface ConversationTableViewController () {
    MBProgressHUD *loadingHud;
    NSString *currentTagName;
    NSMutableString *currentValue;
    BOOL conversationExist;
    BOOL contentExist;
    UIAlertView *alert;
    NSXMLParser *parserGetConversation;
    NSXMLParser *parserGetContent;
    NSString *conversatioinID;
    NSMutableArray *conversation;
}

@end

@implementation ConversationTableViewController

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
    self.navigationController.title = [[JudgeSingleton sharedInstance] getName];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:loadingHud];
    loadingHud.delegate = self;
    loadingHud.labelText = @"载入中……";
    [loadingHud showWhileExecuting:@selector(loadConversation) onTarget:self withObject:nil animated:YES];
}

- (void)loadConversation
{
    NSString *postStr = [NSString stringWithFormat:@"http://61.147.251.189/minterface/getFghh.do?fydm=321300&yhbh=%@&imei=%@", [[JudgeSingleton sharedInstance] getCode], [UUIDHelper generateUUID]];
    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // NSLog(@"url: %@",url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    if (xmlData == nil) {
        alert = [[UIAlertView alloc]
                              initWithTitle:@"查询失败"
                              message:@"连接时发生问题，请稍后再试！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
        [alert show];
    } else {
        parserGetConversation=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
        [parserGetConversation setDelegate:self];
        [parserGetConversation parse];
        // NSLog(@"received: %@",_xmlContent);
        if (!conversationExist) {
            alert = [[UIAlertView alloc] initWithTitle:@"暂无对话" message:@"请返回上一页点击第一次对话按钮新建对话！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert setBackgroundColor:[UIColor blueColor]];
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            [alert show];
        } else {
            [self getContent];
        }
    }
}

- (void)getContent
{
    NSString *postStr = [NSString stringWithFormat:@"http://61.147.251.189/minterface/getHhnr.do?fydm=321300&hhbh=%@", conversatioinID];
    NSURL *url = [NSURL URLWithString:[postStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    // NSLog(@"url: %@",url);
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    if (xmlData == nil) {
        alert = [[UIAlertView alloc]
                 initWithTitle:@"查询失败"
                 message:@"连接时发生问题，请稍后再试！"
                 delegate:self
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil, nil];
        [alert show];
    } else {
        parserGetContent=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
        [parserGetContent setDelegate:self];
        [parserGetContent parse];
        // NSLog(@"received: %@",_xmlContent);
        if (!contentExist) {
            alert = [[UIAlertView alloc] initWithTitle:@"开始对话" message:@"请点击右上角的留言按钮" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert setBackgroundColor:[UIColor blueColor]];
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            [alert show];
        } else {
            [self.tableView reloadData];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [conversation count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChatCell";
    
    ConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ConversationCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    
//    
//    
//    ConversationCell *cell = [[ConversationCell alloc] initWithReuseIdentifier:@"ChatCell"];//= [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    
    SQChat *tmpChat = (SQChat *)[conversation objectAtIndex:indexPath.row];
    
    if ([tmpChat.isJudge isEqualToString:@"N"]) {
        [cell setIsMine:YES];
        [cell initLayuot];
        cell.nameLabel.text = @"我";
    } else {
        [cell setIsMine:NO];
        [cell initLayuot];
        cell.nameLabel.text = @"法官";
    }
    
    [cell setContent:tmpChat.content];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversationCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];	
    return cell.frame.size.height*1.1;
}

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
    SendConversationViewController *destVC = [segue destinationViewController];
    destVC.conversationID = conversatioinID;
}
 */

#pragma mark - NSXMLParser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    if (parser == parserGetConversation) {
        conversationExist = YES;
    } else if (parser == parserGetContent) {
        conversation = [[NSMutableArray alloc]init];
        contentExist = YES;
    }
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
        [conversation addObject:c];
    }
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
    if (parser == parserGetConversation) {
        if ([currentTagName isEqualToString:@"is_success"]) {
            if ([currentValue isEqualToString:@"F"]) {
                conversationExist = NO;
            }
        }
        if ([currentTagName isEqualToString:@"Dh"]) {
            conversatioinID = [currentValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            // NSLog(@"conversation id: %@", conversatioinID);
        }
        currentTagName = nil;
    } else if (parser == parserGetContent) {
        if ([currentTagName isEqualToString:@"is_success"]) {
            if ([currentValue isEqualToString:@"F"]) {
                contentExist = NO;
                return;
            }
        }
        
        SQChat *chat = [conversation lastObject];
        if ([currentTagName isEqualToString:@"Hhnrbh"]) {
            [chat setChatID:currentValue];
        }
        if ([currentTagName isEqualToString:@"Fynr"]) {
            [chat setContent:currentValue];
        }
        if ([currentTagName isEqualToString:@"Sffg"]) {
            [chat setIsJudge:[currentValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
    }
}

@end
