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
#import "JSONKit.h"
#import "Message.h"

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
    
    [self updateUserConfButton];
    
    //判断用户有没有存储用户名和密码，如果存储了，自动登陆
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault objectForKey:@"SavePassword"] ;
    NSString *username = [userDefault objectForKey:@"username"] ;
    NSString *password = [userDefault objectForKey:@"password"] ;
    
    if(self.isAutoLogin){
        if(username != nil && password != nil){
            self.usernameField.text = username ;
            self.passwordField.text = password ;
            [self submitLoginButtonAction:nil] ;
            return ;
        }else{
            self.isAutoLogin = NO ;
            [userDefault setObject:[NSString stringWithFormat:@"%d", self.isAutoLogin] forKey:@"AutoLogin"] ;
        }
    }
    
    self.usernameField.text = @"" ;
    self.passwordField.text = @"" ;
    
    if(self.isSavePasswd){
        if(password != nil){
            self.passwordField.text = password ;
        }
        if(username != nil){
            self.usernameField.text = username ;
        }
    }

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
    if(self.passwordField.text == nil || [@"" isEqualToString:self.passwordField.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"密码不能为空！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    
    //保存用户名和密码
    //判断用户有没有存储用户名和密码，如果存储了，自动登陆
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault objectForKey:@"SavePassword"] ;
    if(self.isSavePasswd){
        [userDefault setObject:self.usernameField.text forKey:@"username"] ;
        [userDefault setObject:self.passwordField.text forKey:@"password"] ;
    }else{
        [userDefault setObject:self.usernameField.text forKey:@"username"] ;
    }
    [userDefault synchronize] ;
    
    //提交请求
    NSString *response = [HTTPTools sendRequestUri:@"/api/auth" Params:[NSDictionary dictionaryWithObjectsAndKeys:self.usernameField.text,@"username",self.passwordField.text, @"password", nil]] ;
    
    NSDictionary *ret = [response objectFromJSONString];
    
    if(ret != nil){
        NSString *errorCode = [ret objectForKey:@"error_code"] ;
        if(errorCode == nil){
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
            appDelegate.isLogin = YES ;
            appDelegate.username = [self.usernameField.text copy] ;
            appDelegate.password = [self.passwordField.text copy] ;
            appDelegate.authorId = [ret objectForKey:@"authorID"] ;
            [appDelegate gotoIndexPage] ;
        }else{
            NSString *errorMessage = [Message getErrorMessageFromErrorCode:errorCode] ;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法访问服务器，请检查您的网络！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction) gotoSignUpButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    [appDelegate gotoSignUpPage] ;
}

- (IBAction) gotoForgetButtonAction:(id)sender
{

}

- (IBAction) savePasswordButtonAction:(id)sender
{
    self.isSavePasswd = !(self.isSavePasswd) ;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSString stringWithFormat:@"%d", self.isSavePasswd] forKey:@"SavePassword"] ;
    [userDefault synchronize];
    [self updateUserConfButton];
}

- (IBAction) autoLoginButtonAction:(id)sender
{
    self.isAutoLogin = !(self.isAutoLogin) ;
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSString stringWithFormat:@"%d", self.isAutoLogin] forKey:@"AutoLogin"] ;
    [userDefault synchronize];
    [self updateUserConfButton];
}

- (void) updateUserConfButton{
    //读取默认参数
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault objectForKey:@"SavePassword"] ;
    NSString *savePassword = [userDefault objectForKey:@"SavePassword"] ;
    NSString *autoLogin = [userDefault objectForKey:@"AutoLogin"] ;
    //[userDefault synchronize];
    
    if(savePassword == nil){
        self.isSavePasswd = NO ;
    }else{
        self.isSavePasswd = [savePassword boolValue] ;
    }
    
    if(autoLogin == nil){
        self.isAutoLogin = NO ;
    }else{
        self.isAutoLogin = [autoLogin boolValue] ;
    }
    
    //更新按钮
    if(self.isSavePasswd){
        [self.savePasswdButton setImage:[UIImage imageNamed:@"panedrow.png"] forState:UIControlStateNormal] ;
    }else{
        [self.savePasswdButton setImage:[UIImage imageNamed:@"pane.png"] forState:UIControlStateNormal] ;
    }
    
    //更新按钮
    if(self.isAutoLogin){
        [self.autoLoginButton setImage:[UIImage imageNamed:@"panedrow.png"] forState:UIControlStateNormal] ;
    }else{
        [self.autoLoginButton setImage:[UIImage imageNamed:@"pane.png"] forState:UIControlStateNormal] ;
    }
    
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
