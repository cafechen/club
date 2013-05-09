//
//  NewsDetailController.h
//  club
//
//  Created by Steven on 13-5-9.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIWebView *webView;


- (IBAction) gotoLastPageButtonAction:(id)sender;

@end
