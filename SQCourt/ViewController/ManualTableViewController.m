//
//  ManualTableViewController.m
//  SQCourt
//
//  Created by Jack on 9/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "ManualTableViewController.h"
#import "ProcessViewController.h"
#import "SQTopic.h"

@interface ManualTableViewController ()

@end

@implementation ManualTableViewController

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
    NSString *path=[[NSBundle mainBundle] pathForResource:@"manual" ofType:@"xml"];
    NSString *_xmlContent=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    [parser setDelegate:self];
    [parser parse];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [_topics count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [(SQTopic *)[_topics objectAtIndex:indexPath.row] topicName];
    
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showProcess"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ProcessViewController *destViewController = [segue destinationViewController];
        NSMutableArray *processes = [(SQTopic *)[_topics objectAtIndex:indexPath.row] processes];
        destViewController.title = [(SQTopic *)[_topics objectAtIndex:indexPath.row] topicName];
        destViewController.processes = processes;
        //         destViewController.contentTextView = [[UITextView alloc] init];
        //         destViewController.contentTextView.text = p.content;
    }
}

#pragma mark - NSXMLParser Delegate
- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    _topics = [[NSMutableArray alloc]init];
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
    if ([currentTagName isEqualToString:@"category"]) {
        SQTopic *t = [[SQTopic alloc] init];
        t.processes = [[NSMutableArray alloc]init];
        [_topics addObject:t];
    }
    if ([currentTagName isEqualToString:@"item"]) {
        SQProcess *p = [[SQProcess alloc] init];
        [[(SQTopic *)[_topics lastObject] processes] addObject:p];
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
    SQTopic *topic = [_topics lastObject];
    
    SQProcess *process = [[(SQTopic *)[_topics lastObject] processes] lastObject];
    
    if  ([currentTagName isEqualToString:@"name"] && topic) {
        [topic setTopicName:currentValue];
    }
	if ([currentTagName isEqualToString:@"title"] && process) {
        [process setTitle:currentValue];
	}
    if ([currentTagName isEqualToString:@"author"] && process) {
        [process setAuthor:currentValue];
	}
    if ([currentTagName isEqualToString:@"time"] && process) {
        [process setTime:currentValue];
	}
    if ([currentTagName isEqualToString:@"content"] && process) {
        [process setContent:currentValue];
	}
    if ([currentTagName isEqualToString:@"editor"] && process) {
        [process setEditor:currentValue];
	}
    currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.processes userInfo:nil];
}


@end
