//
//  ShareDetailController.h
//  club
//
//  Created by Steven on 13-5-11.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareDetailController : UIViewController <UIScrollViewDelegate>

@property (copy, nonatomic) UIImage *avatar;
@property (copy, nonatomic) UIImage *attactment;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *userId;
@property (nonatomic,readwrite) BOOL toPersion;

@property (nonatomic, retain) IBOutlet UIScrollView *backgroundView;
@property (nonatomic, retain) IBOutlet UIImageView *avatarView;
@property (nonatomic, retain) IBOutlet UIImageView *attachView;
@property (nonatomic, retain) IBOutlet UILabel *bodyLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIScrollView *bigImageView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
