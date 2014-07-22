//
//  AboutViewController.m
//  SQCourt
//
//  Created by Jack on 10/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "AboutViewController.h"
#import "Updater.h"
#import "AppDelegate.h"
#import "UserSingleton.h"
#import "LoginViewController.h"
#import "KeychainItemWrapper.h"
#import "Macro.h"
#import "SSKeychain.h"

@interface AboutViewController (){
    LoginViewController *loginVC;
}
@end

@implementation AboutViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _accountLabel.text = [[UserSingleton sharedInstance] getUserName];
    _nameLabel.text = [[UserSingleton sharedInstance] getName];

}

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
    self.tableView.sectionHeaderHeight=0; //消除头部空白
    self.tableView.sectionFooterHeight=0; //消除尾部空白
    self.tableView.backgroundView = [[UIView alloc]init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginView"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [loginVC loginMuted];
    });

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
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 3:
            if (![[((AppDelegate *)[[UIApplication sharedApplication] delegate]) updater] checkUpdate]) {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"该版本为最新！";
                hud.margin = 10.f;
                hud.yOffset = 150.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:3];
                [tableView deselectRowAtIndexPath:indexPath animated:NO];
            }
            break;
        case 1:
            if ([[[UserSingleton sharedInstance] getUserID] isEqualToString:@""]) {
                
                UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self presentModalViewController:navigation animated:NO];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已登录"
                                                                message:@"您已经登录，若要切换帐号请先注销！"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];

            }
            break;
        case 2:
            [self logout];
            break;
        default:
            break;
    }
}

-(void)logout
{
	[SSKeychain deletePasswordForService:kSSServiceName account:[[UserSingleton sharedInstance] getUserName]];
    
    [[UserSingleton sharedInstance] setUserID:@""];
    [[UserSingleton sharedInstance] setCaseID:@""];
    
    _accountLabel.text = @"";
    _nameLabel.text = @"";
    [self viewDidAppear:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
