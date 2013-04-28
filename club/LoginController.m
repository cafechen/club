    //
//  LoginController.m
//  club
//
//  Created by steven on 13-4-28.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import "Define.h"
#import "AppDelegate.h"
#import "HTTPTools.h"
#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

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
    NSLog(@"%d", isIPhone5) ;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) submitLoginButtonAction:(id)sender
{
    //校验用户名密码
    if(self.usernameField.text == nil || [@"" isEqualToString:self.usernameField.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"用户名不能为空！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    if(self.usernameField.text == nil || [@"" isEqualToString:self.passwordField.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码不能为空！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    //提交请求
    NSDictionary *ret = [HTTPTools sendRequestUri:@"/statusnetadmin/index.php/api/auth" Params:[NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text,@"username",self.passwordField.text, @"password", nil]] ;
    
    if(ret != nil){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", ret] message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    
    NSLog(@"%@", ret) ;
}

- (IBAction) gotoSignUpButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    [appDelegate gotoSignUpPage] ;
}

- (IBAction) gotoForgetButtonAction:(id)sender
{

}


#pragma mark -
#pragma mark UITextFieldDelegate Methods

- (void)keyboardWillShow:(NSNotification *)noti
{
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)theTextField
{
}

- (void)textFieldDidEndEditing:(UITextField *)theTextField
{
}

-(BOOL)textField:(UITextField *)theTextField shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [theTextField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
