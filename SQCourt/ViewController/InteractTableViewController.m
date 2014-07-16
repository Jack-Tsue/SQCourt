//
//  InteractTableViewController.m
//  SQCourt
//
//  Created by Jack on 19/6/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "InteractTableViewController.h"
#import "UserSingleton.h"
#import "LoginViewController.h"
#import "ContactViewController.h"
#import "SQChatListViewController.h"

@interface InteractTableViewController ()

@end

@implementation InteractTableViewController

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
    if ([[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginView"];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentModalViewController:navigation animated:NO];
    }
    if ([[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    return 4;
}

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"flzx"]){
        ContactViewController *destVC = [segue destinationViewController];
        destVC.type = @"1";
        destVC.title = @"法律咨询";
        destVC.hintText=@"说明：社会公众可以在此进行法律咨询。您的咨询内容和我们的回复内容，您能在消息记录中看到。";
    } else if ([segue.identifier isEqualToString:@"tsjb"]) {
        ContactViewController *destVC = [segue destinationViewController];
        destVC.type = @"2";
        destVC.title = @"投诉举报";
        destVC.hintText=@"说明：案件当事人及相关人员在此对案件审判执行中的违法违规行动进行投诉举报，您的投诉举报和我们的回复内容，您能在消息记录中看到。";
    } else if ([segue.identifier isEqualToString:@"yjjy"]) {
        ContactViewController *destVC = [segue destinationViewController];
        destVC.type = @"3";
        destVC.title = @"意见建议";
        destVC.hintText=@"说明：社会公众可以在此对法院工作提出意见建议，您的意见建议和我们的回复内容，您能在消息记录中看到。";
    } else if ([segue.identifier isEqualToString:@"Interact_MsgRecord"]) {
        SQChatListViewController *destVC = [segue destinationViewController];
        destVC.segControl.selectedSegmentIndex = 1;
        [destVC.segControl setHidden:YES];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
