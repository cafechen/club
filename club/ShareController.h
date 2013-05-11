//
//  ShareController.h
//  club
//
//  Created by steven on 13-5-10.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (retain, nonatomic) IBOutlet UIButton *attachButton;

@property (retain, nonatomic) IBOutlet UIButton *attachButton2;

@property (nonatomic, retain) IBOutlet UITextView *textView;

@property (retain, nonatomic) IBOutlet UIView *loadingView ;

- (IBAction) addAttentment:(id)sender;

- (IBAction) addAttentmentPhoto:(id)sender;

- (IBAction) gotoLastPageButtonAction:(id)sender;

- (IBAction) sendButtonAction:(id)sender;

@end
