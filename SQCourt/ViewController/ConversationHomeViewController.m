//
//  ConversationHomeViewController.m
//  SQCourt
//
//  Created by Jack on 23/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "ConversationHomeViewController.h"
#import "UIButton+Bootstrap.h"
#import "ConversationTableViewController.h"
#import "JudgeSingleton.h"

@interface ConversationHomeViewController ()

@end

@implementation ConversationHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_createBtn infoStyle];
    [_continueBtn dangerStyle];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showConversation"]) {
        ConversationTableViewController *destViewController = [segue destinationViewController];
        destViewController.title = [[JudgeSingleton sharedInstance] getName];
    }

    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
