//
//  SignUpController.h
//  club
//
//  Created by steven on 13-4-28.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *emailField;

@property (nonatomic, retain) IBOutlet UITextField *usernameField;

@property (nonatomic, retain) IBOutlet UITextField *passwordField;

@property (nonatomic, retain) IBOutlet UITextField *rpasswordField;

@property (nonatomic, readwrite) BOOL isAutoLogin;

@property (nonatomic, readwrite) BOOL isSavePasswd;

@property (retain, nonatomic) IBOutlet UIButton *savePasswdButton;

@property (retain, nonatomic) IBOutlet UIButton *autoLoginButton;

@end
