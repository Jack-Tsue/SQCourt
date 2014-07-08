//
//  LoginWithCaseIDViewController.m
//  SQCourt
//
//  Created by Jack on 20/5/14.
//  Copyright (c) 2014 Jack. All rights reserved.
//

#import "LoginWithCaseIDViewController.h"
#import "UserSingleton.h"
#import "KeychainItemWrapper.h"
#import "Macro.h"
#import "UIButton+Bootstrap.h"

@interface LoginWithCaseIDViewController () {
    NSString *caseID;
    UIAlertView *errorAlert;
}

@end

@implementation LoginWithCaseIDViewController

- (void)viewDidLoad
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
        
    if (isIos7System) {
        [self.loginBtn primaryStyle];
    } else {
        //        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_loginBtn.titleLabel setBackgroundColor:[UIColor clearColor]];
        //        [_loginBtn.titleLabel setTextColor:[UIColor redColor]];
        //        [_loginBtn setBackgroundImage:[self createImageWithColor:[UIColor blueColor]]  forState:UIControlStateNormal];
        //        _loginBtn.backgroundColor = [UIColor blackColor];
        [self.loginBtn primaryStyle];
        
    }
    
    self.caseIDTextField.delegate = self;
    
    CALayer *layer=[self.logoImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:10.0];
    [layer setBorderWidth:2];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [self.loginBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)submit:(id)sender
{
    [self login];
}

- (void)login
{
    if (!caseID || [caseID isEqualToString:@""]) {
        caseID = _caseIDTextField.text;
    }
    if ([caseID isEqualToString:@""]) {
        [self alert];
    } else {
        [[UserSingleton sharedInstance] setCaseID:caseID];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.caseIDTextField resignFirstResponder];
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

#pragma mark -
#pragma mark 解决虚拟键盘挡住UITextField的方法  UITextField Delegate methods

//解决虚拟键盘挡住UITextField的方法，键盘若遮住，view上移
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

//键盘隐藏后，view还原
- (void) textFieldDidEndEditing:(UITextField *)textField {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
}

- (void)alert
{
    errorAlert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"请检查是否有未填写的项！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [errorAlert show];
    
}

@end
