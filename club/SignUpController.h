//
//  SignUpController.h
//  club
//
//  Created by steven on 13-4-28.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *usernameField;

@property (nonatomic, retain) IBOutlet UITextField *passwordField;

@property (nonatomic, retain) IBOutlet UITextField *rpasswordField;

@end
