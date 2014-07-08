//
//  DepartmentTableViewController.m
//  SQCourt
//
//  Created by Jack on 8/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "DepartmentTableViewController.h"
#import "SQDepartment.h"
#import "JudgeTableViewController.h"
#import "DepartmentDetailViewController.h"
#import "UserSingleton.h"

@interface DepartmentTableViewController ()

@end

@implementation DepartmentTableViewController

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
    NSURL *url = [NSURL URLWithString:@"http://61.147.251.189/minterface/getBm.do?fydm=321300"];
    NSData *xmlData = [NSData dataWithContentsOfURL:url];
    NSString *_xmlContent=[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    if (xmlData == nil) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"查询失败"
                              message:@"连接时发生问题，请稍后再试！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
        [alert show];
    }
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser parse];
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
    return [_departments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"departmentCell" forIndexPath:indexPath];
    
    // Configure the cell...
    SQDepartment *d = [_departments objectAtIndex:indexPath.row];
    cell.textLabel.text = [d depName];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showJudges"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JudgeTableViewController *destViewController = [segue destinationViewController];
        SQDepartment *d = [_departments objectAtIndex:indexPath.row];
        destViewController.title = [d depName];
        destViewController.isShow = YES;
        [destViewController setDepNum:d.depNum];
        //         destViewController.contentTextView = [[UITextView alloc] init];
        //         destViewController.contentTextView.text = p.content;
    } else if ([segue.identifier isEqualToString:@"showDepDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DepartmentDetailViewController *destViewController = [segue destinationViewController];
        SQDepartment *d = [_departments objectAtIndex:indexPath.row];
        destViewController.title = [d depName];
        destViewController.content = [d depDescription];
        //         destViewController.contentTextView = [[UITextView alloc] init];
        //         destViewController.contentTextView.text = p.content;
    }

}

#pragma mark - NSXMLParser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    _departments = [[NSMutableArray alloc]init];
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
    if ([currentTagName isEqualToString:@"Department"]) {
        SQDepartment *d = [[SQDepartment alloc] init];
        [_departments addObject:d];
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
    SQDepartment *department = [_departments lastObject];
    
	if ([currentTagName isEqualToString:@"Bmbh"] && department) {
        [department setDepNum:currentValue];
	}
    if ([currentTagName isEqualToString:@"Bmdm"] && department) {
        [department setDepCode:currentValue];
	}
    if ([currentTagName isEqualToString:@"Bmmc"] && department) {
        [department setDepName:currentValue];
	}
    if ([currentTagName isEqualToString:@"Bmms"] && department) {
        [department setDepDescription:currentValue];
	}
    
    currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.processes userInfo:nil];
}
@end
