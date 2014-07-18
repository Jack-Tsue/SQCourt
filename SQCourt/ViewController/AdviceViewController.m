//
//  AdviceViewController.m
//  SQCourt
//
//  Created by Jack on 23/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "AdviceViewController.h"
#import "AdviceCell.h"
#import "BasicInfoCell.h"
#import "SQAdviceReply.h"
#import "Macro.h"
#import "SQAdvice.h"

@interface AdviceViewController (){
    MBProgressHUD *loadingHud;
    NSString *currentTagName;
    NSMutableString *currentValue;
    BOOL isSuccess;
    UIAlertView *alert;
    NSMutableArray *adviceReplyList;
}


@end

@implementation AdviceViewController

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
    loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:loadingHud];
    loadingHud.delegate = self;
    loadingHud.labelText = @"载入中……";
    [loadingHud showWhileExecuting:@selector(loadReply) onTarget:self withObject:nil animated:YES];
}

- (void)loadReply
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@getYjhf.do?yjjybh=%@", INTERFACE_ADDRESS,  _advice.adivceID]];
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
        [self.tableView reloadData];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section==0) {
        return 1;
    }
    return [adviceReplyList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AdviceCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height*1.1;
        
    } if (indexPath.section == 1) {
        BasicInfoCell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height*1.1;
        
    } else {
        return 30;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
        return @"意见建议详情";
        case 1:
        return @"意见建议回复";
        default:
        return nil;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AdviceCell *cell = [[AdviceCell alloc] initWithReuseIdentifier:@"AdviceInfoCell"];
        cell.name.text = _advice.name;
        cell.phone.text = _advice.phone;
        cell.qq.text = [NSString stringWithFormat:@"%@ (%@)", _advice.qq, _advice.time];
        [cell setIntroductionText:_advice.adviceContent];
        return cell;
    } else {
        BasicInfoCell *cell = [[BasicInfoCell alloc] initWithReuseIdentifier:@"AdviceReplyCell" ];

        SQAdviceReply *ar = (SQAdviceReply *)[adviceReplyList objectAtIndex:indexPath.row];
        cell.title.text = ar.getReplyDate;
        [cell setDetailText:ar.replyContent];
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
    adviceReplyList = [[NSMutableArray alloc]init];
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
    if ([currentTagName isEqualToString:@"hf"]) {
        SQAdviceReply *r = [[SQAdviceReply alloc] init];
        [adviceReplyList addObject:r];
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
    SQAdviceReply *reply = [adviceReplyList lastObject];
    
	if ([currentTagName isEqualToString:@"hfbh"] && reply) {
        [reply setReplyID:currentValue];
	}
    if ([currentTagName isEqualToString:@"yhbh"] && reply) {
        [reply setJudgeID:currentValue];
	}
    if ([currentTagName isEqualToString:@"yjjybh"] && reply) {
        [reply setAdivceID:currentValue];
	}
    if ([currentTagName isEqualToString:@"hfsj"] && reply) {
        [reply setReplyTime:currentValue];
	}
    if ([currentTagName isEqualToString:@"hfnr"] && reply) {
        [reply setReplyContent:currentValue];
	}
    currentTagName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:self.processes userInfo:nil];
}
@end
