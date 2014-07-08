//
//  JudgeTableViewController.m
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "JudgeTableViewController.h"
#import "JudgeViewController.h"
#import "JudgeSingleton.h"
#import "UserSingleton.h"
#import "ChatViewController.h"
#import "Macro.h"
#import "LoginWithCaseIDViewController.h"
#import "SSKeychain.h"

@interface JudgeTableViewController () {
}

@end

@implementation JudgeTableViewController

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
    // Set determinate mode
	HUD.mode = MBProgressHUDModeDeterminate;
	
	HUD.delegate = self;
	HUD.labelText = @"载入中...";
	
	[HUD showWhileExecuting:@selector(parseXML) onTarget:self withObject:nil animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    
    
    
}

- (void)parseXML
{
    NSURL *url ;
    if (_isShow) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",INTERFACE_ADDRESS, @"getFg.do?fydm=321300&bmbh=", _depNum]];

    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",INTERFACE_ADDRESS, @"getFgByCase.do?fydm=321300&caseID=", [[UserSingleton sharedInstance] getCaseID]]];
    }
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser parse];
    if ([_judges count] < 1 && ![[[UserSingleton sharedInstance] getCaseID] isEqualToString:@""]) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"注意" message:@"请检查案件查询码是否正确，或者该案件是否由本院法官承办" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [errorAlert show];
    }
    [self.tableView reloadData];
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
    return [_judges count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JudgeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    SQJudge *j = [_judges objectAtIndex:indexPath.row];
    cell.textLabel.text = [j judgeName];
    return cell;
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
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SQJudge *j = [_judges objectAtIndex:indexPath.row];

    if ([segue.identifier isEqualToString:@"showJudge"]) {
        JudgeViewController *destViewController = [segue destinationViewController];
        destViewController.title = self.title;
        destViewController.judgePic = j.judgePic;
        destViewController.judgeID = j.judgeID;
        destViewController.judgeName = j.judgeName;
        destViewController.judgeResume = j.judgeResume;
    } if ([segue.identifier isEqualToString:@"contactJudge"]) {
        [[JudgeSingleton sharedInstance] setCode:j.judgeID];
        [[JudgeSingleton sharedInstance] setName:j.judgeName];
        ChatViewController *destViewController = [segue destinationViewController];
        destViewController.title = j.judgeName;
        destViewController.isContactJudge = YES;
        destViewController.conversation.judgeID = j.judgeID;

    }
}

#pragma mark - NSXMLParser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    _judges = [[NSMutableArray alloc]init];
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
    if ([currentTagName isEqualToString:@"Judge"]) {
        SQJudge *j = [[SQJudge alloc] init];
        [_judges addObject:j];
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
    SQJudge *judge = [_judges lastObject];
    
	if ([currentTagName isEqualToString:@"Id"] && judge) {
        [judge setJudgeID:currentValue];
	}
    if ([currentTagName isEqualToString:@"Name"] && judge) {
        [judge setJudgeName:currentValue];
	}
    if ([currentTagName isEqualToString:@"Picture"] && judge) {
        [judge setJudgePic:currentValue];
	}
    if ([currentTagName isEqualToString:@"Resume"] && judge) {
        [judge setJudgeResume:currentValue];
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

    LoginWithCaseIDViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewWithCaseID"];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self presentModalViewController:navigation animated:NO];
}
@end
