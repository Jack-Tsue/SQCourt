//
//  CaseCalculatorViewController.m
//  SQCourt
//
//  Created by Jack on 9/4/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "CaseCalculatorViewController.h"

@interface CaseCalculatorViewController ()

@end

@implementation CaseCalculatorViewController

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
    self.scrollView.contentSize = CGSizeMake(320, 600);

    _fortuneCase = [[UILabel alloc] initWithFrame:CGRectMake(135, 127, 130, 21)];
    [_scrollView addSubview:_fortuneCase];

    _marriageCase = [[UILabel alloc] initWithFrame:CGRectMake(135, 156, 130, 21)];
    [_scrollView addSubview:_marriageCase];
    
    _humanRightsCase = [[UILabel alloc] initWithFrame:CGRectMake(152, 185, 130, 21)];
    [_scrollView addSubview:_humanRightsCase];
    
    _fortuneKeep = [[UILabel alloc] initWithFrame:CGRectMake(135, 252, 130, 21)];
    [_scrollView addSubview:_fortuneKeep];
    
    _executeCase = [[UILabel alloc] initWithFrame:CGRectMake(135, 281, 130, 21)];
    [_scrollView addSubview:_executeCase];
    
    _bankruptCase = [[UILabel alloc] initWithFrame:CGRectMake(135, 310, 130, 21)];
    [_scrollView addSubview:_bankruptCase];
    
    _payOrder = [[UILabel alloc] initWithFrame:CGRectMake(118, 339, 130, 21)];
    [_scrollView addSubview:_payOrder];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [_scrollView addGestureRecognizer:tapGr];
    
    [_calculateBtn addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    [_input resignFirstResponder];
}

-(void)calculate:(id)sender
{
    _amount = [_input.text intValue];
    if (_amount<0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"
                                                        message:@"您输入的金额无效！"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        [self calculateFortuneCase];
        [self calculateMarraigaeCase];
        [self calculateHumanRightsCase];
        [self calculateFortuneKeep];
        [self calculateExecuteCase];
        [self calculateBankruptCase];
        [self calculatePayOrder];
    }
}

- (void)calculateFortuneCase
{
    if (_amount<=10000) {
        [_fortuneCase setText:[NSString stringWithFormat:@"%d%@", 50, @"元"]];
    } else if (_amount<=100000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.025-200, @"元"];
    } else if (_amount<=200000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.02+300, @"元"];
    } else if (_amount<=500000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.015+1300, @"元"];
    } else if (_amount<=1000000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.01+3800, @"元"];
    } else if (_amount<=2000000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.009+4800, @"元"];
    } else if (_amount<=5000000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.008+6800, @"元"];
    } else if (_amount<=10000000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.007+11800, @"元"];
    } else if (_amount<=20000000) {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.006+21800, @"元"];
    } else {
        _fortuneCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.005+41800, @"元"];
    }
}

- (void)calculateMarraigaeCase
{
    if (_amount<=200000) {
        _marriageCase.text = [NSString stringWithFormat:@"%.1f%@", 300.00f, @"元"];
    } else {
        _marriageCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.005+41800, @"元"];
    }
}

- (void)calculateHumanRightsCase
{
    if (_amount<=50000) {
        _humanRightsCase.text = [NSString stringWithFormat:@"%.1f%@", 500.00f, @"元"];
    } else if (_amount <= 100000){
        _humanRightsCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.01, @"元"];
    } else if (_amount > 100000){
        _humanRightsCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.005+500, @"元"];
    }
}

- (void)calculateFortuneKeep
{
    if (_amount<=1000) {
        _fortuneKeep.text = [NSString stringWithFormat:@"%.1f%@", 30.00f, @"元"];
    } else if (_amount<=100000) {
        _fortuneKeep.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.01+20, @"元"];
    } else {
        _fortuneKeep.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.005+520, @"元"];
    }
}

- (void)calculateExecuteCase
{
    if (_amount==0) {
        [_executeCase setText:[NSString stringWithFormat:@"%.1f%@", 500.0f, @"元"]];
    } else if (_amount<=10000) {
        [_executeCase setText:[NSString stringWithFormat:@"%.1f%@", 50.0f, @"元"]];
    } else if (_amount<=500000) {
        _executeCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.015-100, @"元"];
    } else if (_amount<=5000000) {
        _executeCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.01+2400, @"元"];
    } else if (_amount<=10000000) {
        _executeCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.005+27400, @"元"];
    } else {
        _executeCase.text = [NSString stringWithFormat:@"%.1f%@", _amount*0.001+67400, @"元"];
    }
}

- (void)calculateBankruptCase
{
    float fortuneCaseCost = [_fortuneCase.text floatValue];
    _bankruptCase.text = [NSString stringWithFormat:@"%.1f%@", fortuneCaseCost/2, @"元"];
}

- (void)calculatePayOrder
{
    float fortuneCaseCost = [_fortuneCase.text floatValue];
    _payOrder.text = [NSString stringWithFormat:@"%.1f%@", fortuneCaseCost/3, @"元"];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
