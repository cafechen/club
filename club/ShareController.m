//
//  ShareController.m
//  club
//
//  Created by steven on 13-5-10.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import "AppDelegate.h"
#import "ShareController.h"
#import "NSString+URLEncoding.h"
#import "HTTPTools.h"
#import <QuartzCore/QuartzCore.h>

@interface ShareController ()

@end

@implementation ShareController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"社交分享", @"社交分享");
        self.tabBarItem.image = [UIImage imageNamed:@"public"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.text = @"" ;
    self.textView.layer.borderWidth =1.0;
    self.textView.layer.cornerRadius =5.0;
    
    self.imageView.image = nil ;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.attachButton.hidden = NO ;
    self.attachButton2.hidden = NO ;
    self.attachButton.enabled = YES ;
    self.attachButton2.enabled = YES ;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) addAttentment:(id)sender
{
    [_textView resignFirstResponder];
    //相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = sourceType;
    
    [self presentModalViewController:picker animated:YES];
}

- (IBAction) addAttentmentPhoto:(id)sender
{
    [_textView resignFirstResponder];
    //相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = sourceType;
    [self presentModalViewController:picker animated:YES];
}

- (void)saveImage:(UIImage *)image {
    self.imageView.image = image ;
    //self.imageView.hidden = NO ;
    NSLog(@"保存");
}

#pragma mark –
#pragma mark Camera View Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *originalImage, *editedImage, *imageToSave;
    
    editedImage = (UIImage *) [info objectForKey:
                               UIImagePickerControllerEditedImage];
    originalImage = (UIImage *) [info objectForKey:
                                 UIImagePickerControllerOriginalImage];
    
    if (editedImage) {
        imageToSave = editedImage;
    } else {
        imageToSave = originalImage;
    }
    
    [picker dismissModalViewControllerAnimated:YES];
    
    [self performSelector:@selector(saveImage:)
               withObject:imageToSave
               afterDelay:0.5];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark –
#pragma mark UINavigationControllerDelegate Delegate Methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
}

#pragma mark –
#pragma mark UITextViewDelegate Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)theTextView
{
    
}

- (void)textViewDidEndEditing:(UITextView *)theTextView
{
    
}

-(BOOL)textView:(UITextView *)theTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [theTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_textView isFirstResponder] && [touch view] != _textView) {
        [_textView resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (IBAction) sendButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;

    if(self.textView.text == nil || [@"" isEqualToString:self.textView.text]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"内容不能为空！" message:nil delegate:self cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    
    if([self.textView.text length] > 70){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"内容不能超过70个字！" message:nil delegate:self cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        return ;
    }
    
    if(self.imageView.image == nil){
        [NSThread detachNewThreadSelector:@selector(showLoading) toTarget:self withObject:nil];
        if([HTTPTools sendMessageHttpUserName: appDelegate.username
                                     Password: appDelegate.password
                                       Status: [self.textView.text URLEncodedString]
                                       UserId: appDelegate.authorId]){
            [NSThread detachNewThreadSelector:@selector(removeLoading) toTarget:self withObject:nil];
            [appDelegate gotoLastTLPage] ;
        }else{
            [NSThread detachNewThreadSelector:@selector(removeLoading) toTarget:self withObject:nil];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"服务器异常，发送失败！" message:nil delegate:self cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }else{
        [NSThread detachNewThreadSelector:@selector(showLoading) toTarget:self withObject:nil];
        if([HTTPTools sendMessageImageHttpUserName: appDelegate.username
                                          Password: appDelegate.password
                                            Status: self.textView.text
                                            UserId: appDelegate.authorId
                                             Image: self.imageView.image]){
            [NSThread detachNewThreadSelector:@selector(removeLoading) toTarget:self withObject:nil];
            [appDelegate gotoLastTLPage] ;
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"服务器异常，发送失败！" message:nil delegate:self cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [NSThread detachNewThreadSelector:@selector(removeLoading) toTarget:self withObject:nil];
            [alertView show];
        }
    }
}

- (IBAction) gotoLastPageButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    [appDelegate gotoLastPage3] ;
}

- (void) showLoading
{
    [self.view addSubview:self.loadingView] ;
}

- (void) removeLoading
{
    [self.loadingView removeFromSuperview] ;
}

@end