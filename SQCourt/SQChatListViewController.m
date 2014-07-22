//
//  SQChatListViewController.m
//  SQJudge
//
//  Created by Jack on 25/4/14.
//  Copyright (c) 2014 Faxi Tech. All rights reserved.
//

#import "SQChatListViewController.h"
#import "UserSingleton.h"
#import "JudgeSingleton.h"
#import "SQConversation.h"
#import "Macro.h"
#import "ChatViewController.h"
#import "SSKeychain.h"
#import "LoginWithCaseIDViewController.h"
#import "SQAdvice.h"
#import "AdviceViewController.h"

@interface SQChatListViewController (){
    MBProgressHUD *loadingHud;
    NSString *currentTagName;
    NSMutableString *currentValue;
    BOOL isSuccess;
    UIAlertView *alert;
    NSMutableArray *conversationList;
    NSMutableArray *adviceList;
    BOOL isAdviceView;
}

@end

@implementation SQChatListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    if ([[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginView"];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navigation animated:NO];

    }
    if (![[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
        loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:loadingHud];
        loadingHud.delegate = self;
        loadingHud.labelText = @"载入中……";
        if (isAdviceView) {
            [loadingHud showWhileExecuting:@selector(loadComments) onTarget:self withObject:nil animated:YES];
        } else {
            [loadingHud showWhileExecuting:@selector(loadConversations) onTarget:self withObject:nil animated:YES];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_segControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self segmentAction:self.segControl];
}

-(void)segmentAction:(UISegmentedControl *)Seg
{
    NSInteger index = Seg.selectedSegmentIndex;
    switch (index) {
        case 0:
            // NSLog(@"0 clicked.");
            isAdviceView = NO;
            [loadingHud showWhileExecuting:@selector(loadConversations) onTarget:self withObject:nil animated:YES];
            break;
        case 1:
            // NSLog(@"1 clicked.");
            isAdviceView = YES;
            [loadingHud showWhileExecuting:@selector(loadComments) onTarget:self withObject:nil animated:YES];
            break;
        default:
            break;
    }
}

- (void)loadConversations
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@getUserFghh.do?fydm=321300&userid=%@", INTERFACE_ADDRESS, [[UserSingleton sharedInstance] getUserID]]];
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }

    });
}

- (void)loadComments
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@getYjjyByUserid.do?userid=%@", INTERFACE_ADDRESS, [[UserSingleton sharedInstance] getUserID]]];
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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    });
    
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
    if (isAdviceView) {
        return [adviceList count];
    }
    return [conversationList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Configure the cell...
    if (isAdviceView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdviceCell" forIndexPath:indexPath];
        SQAdvice *tmpAdv = ((SQAdvice *)[adviceList objectAtIndex:indexPath.row]);
        cell.textLabel.text = [NSString stringWithFormat:@"【%@】%@", [tmpAdv type], tmpAdv.qq];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        return cell;

    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
        SQConversation *tmpCon = ((SQConversation *)[conversationList objectAtIndex:indexPath.row]);
        cell.textLabel.text = tmpCon.judgeName;
        if ([tmpCon.unread isEqualToString:@"0"]) {
            cell.detailTextLabel.text = @"";
        } else {
            cell.detailTextLabel.text = tmpCon.unread;
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
        return cell;
    }
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"chat"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SQConversation *conversation = (SQConversation *)[conversationList objectAtIndex:indexPath.row];
        ChatViewController *destViewController = [segue destinationViewController];
        destViewController.title = conversation.judgeName;
        destViewController.isContactJudge = NO;
        destViewController.navigationController.title = @"消息记录";
        destViewController.conversation = conversation;
    }
    if ([segue.identifier isEqualToString:@"advice"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SQAdvice *a = (SQAdvice *)[adviceList objectAtIndex:indexPath.row];
        AdviceViewController *destViewController = [segue destinationViewController];
        destViewController.title = a.type;
        destViewController.advice = a;
    }
}


#pragma mark - NSXMLParser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    conversationList = [[NSMutableArray alloc]init];
    adviceList = [[NSMutableArray alloc]init];
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
    if ([currentTagName isEqualToString:@"Fghh"]) {
        SQConversation *c = [[SQConversation alloc] init];
        [conversationList addObject:c];
    } else if ([currentTagName isEqualToString:@"Yjjy"]) {
        SQAdvice *a = [[SQAdvice alloc] init];
        [adviceList addObject:a];
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
    if (isAdviceView) {
        SQAdvice *advice = [adviceList lastObject];
        if ([currentTagName isEqualToString:@"Yjjybh"]&&advice) {
            [advice setAdivceID:currentValue];
        }
        if ([currentTagName isEqualToString:@"Xm"]&&advice) {
            [advice setName:currentValue];
        }
        if ([currentTagName isEqualToString:@"Lxdh"]&&advice) {
            [advice setPhone:currentValue];
        }
        if ([currentTagName isEqualToString:@"Bt"]&&advice) {
            if ([currentValue isEqualToString:@"null"]) {
                currentValue = @"无标题";
            }
            [advice setQq:currentValue];
        }
        if ([currentTagName isEqualToString:@"Type"]&&advice) {
            [advice setType:currentValue];
        }
        if ([currentTagName isEqualToString:@"Yjjynr"]&&advice) {
            [advice setAdviceContent:currentValue];
        }
        if ([currentTagName isEqualToString:@"time"]&&advice) {
            [advice setTime:currentValue];
        }
    } else {
        SQConversation *conversation = [conversationList lastObject];
        
        if ([currentTagName isEqualToString:@"Hhbh"] && conversation) {
            [conversation setConversationID:currentValue];
        }
        if ([currentTagName isEqualToString:@"Dh"] && conversation) {
            [conversation setPhone:currentValue];
        }
        if ([currentTagName isEqualToString:@"Fgbh"] && conversation) {
            [conversation setJudgeID:currentValue];
        }
        if ([currentTagName isEqualToString:@"Fg"] && conversation) {
            [conversation setJudgeName:currentValue];
        }
        if ([currentTagName isEqualToString:@"Xm"] && conversation) {
            [conversation setName:currentValue];
        }
        if ([currentTagName isEqualToString:@"Unread"] && conversation) {
            [conversation setUnread:currentValue];
        }
        if ([currentTagName isEqualToString:@"Time"] && conversation) {
            [conversation setTime:currentValue];
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
