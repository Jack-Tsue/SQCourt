//
//  NoticeViewController.m
//  TEST
//
//  Created by Jack on 3/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "NoticeViewController.h"
#import "TableViewCell.h"
#import "HTMLParser.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

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
    _notices = [[NSMutableArray alloc] init];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	// Set determinate mode
	HUD.mode = MBProgressHUDModeDeterminate;
	
	HUD.delegate = self;
	HUD.labelText = @"载入中...";
	
	[HUD showWhileExecuting:@selector(parseXML) onTarget:self withObject:nil animated:YES];
}

- (void)parseXML {
    NSDateFormatter *formater = [[ NSDateFormatter alloc] init];
    NSDate *curDate = [NSDate date];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString * curTime = [formater stringFromDate:curDate];
    // NSLog(@"%@",curTime);
    
    NSTimeInterval oneYearTimeInterval = 24*60*60*365;
    NSDate *nextDate = [curDate addTimeInterval:oneYearTimeInterval];
    NSString * nextTime = [formater stringFromDate:nextDate];
    // NSLog(@"%@",nextTime);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://221.226.175.76:8018/ajcx/webapp/ktxx_info_do.jsp?fydm=321300&kssj=%@&jssj=%@", curTime, nextTime]];
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        // NSLog(@"Error: %@", error);
        [self parsingDidTimeout];
        return;
    }
    
    HTMLNode *bodyNode = [parser body];
    
    NSArray *tdNodes = [bodyNode findChildTags:@"td"];
    
    for (HTMLNode *spanNode in tdNodes) {
        NSString *content = [spanNode contents];
        if (content == nil) {
            content = @"";
        }
        [_notices addObject:content];
    }
    [self.tableView reloadData];
//    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    //    NSString *path=[[NSBundle mainBundle] pathForResource:@"notice" ofType:@"xml"];
    //    NSString *_xmlContent=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    parser=[[NSXMLParser alloc] initWithData:[_xmlContent dataUsingEncoding:NSUTF8StringEncoding]];
    
    
//    [parser setDelegate:self];
//    [parser parse];
}

- (void)parsingDidTimeout {
    UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"查询失败"
                              message:@"连接时发生问题，请稍后再试！"
                              delegate:self
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return ([_notices count]/4);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"NoticeCell";
//    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    if (cell == nil) {
//        cell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                      reuseIdentifier:CellIdentifier];
//    }
//
//    // Configure the cell...
//    cell.caseNoLabel.text =n.caseNo;
//    cell.caseDateLabel.text = n.caseDate;
//    cell.courtLabel.text = n.court;
//    cell.caseNameLabel.text = n.caseName;

    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    
    cell.caseDate.text = [_notices objectAtIndex:(4*indexPath.row)];
    [cell setIntroductionText:[_notices objectAtIndex:(4*indexPath.row+1)]];
    cell.caseNo.text =[_notices objectAtIndex:(4*indexPath.row+2)];
    cell.court.text = [_notices objectAtIndex:(4*indexPath.row+3)];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
@end
