//
//  ShareCell.h
//  pengpengtou
//
//  Created by steven on 12-12-23.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ShareCell : UITableViewCell <UITextViewDelegate>

@property (copy, nonatomic) UIImage *avatar;
@property (copy, nonatomic) UIImage *attactment;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *userId;
@property (nonatomic,readwrite) BOOL toPersion;

@property (nonatomic, retain) IBOutlet UIImageView *avatarView;
@property (nonatomic, retain) IBOutlet UIImageView *attachView;
@property (nonatomic, retain) IBOutlet UILabel *bodyLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

@end
