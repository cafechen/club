//
//  LoginController.h
//  club
//
//  Created by steven on 13-4-28.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *usernameField;

@property (nonatomic, retain) IBOutlet UITextField *passwordField;

- (IBAction) submitLoginButtonAction:(id)sender ;

- (IBAction) gotoSignUpButtonAction:(id)sender ;

- (IBAction) gotoForgetButtonAction:(id)sender ;

@end
