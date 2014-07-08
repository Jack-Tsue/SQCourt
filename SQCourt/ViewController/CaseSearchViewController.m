//
//  CaseSearchViewController.m
//  SQCourt
//
//  Created by Jack on 25/3/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "CaseSearchViewController.h"
#import "SearchResultViewController.h"

@interface CaseSearchViewController ()

@end

@implementation CaseSearchViewController

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
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    [_clearBtn addTarget:self action:@selector(clearTextFields:) forControlEvents:UIControlEventTouchUpInside];

	// Do any additional setup after loading the view.
}

-(void)clearTextFields:(id)sender
{
    _caseYearTextField.text = nil;
    _caseNoTextField.text = nil;
    _searchKeyTextField.text = nil;
    [_caseYearTextField resignFirstResponder];
    [_caseNoTextField resignFirstResponder];
    [_searchKeyTextField resignFirstResponder];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [_caseYearTextField resignFirstResponder];
    [_caseNoTextField resignFirstResponder];
    [_searchKeyTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SearchResultViewController *viewController = segue.destinationViewController;
    [viewController setKey:_searchKeyTextField.text withCaseYear:_caseYearTextField.text withCaseNo:_caseNoTextField.text];
}
@end
