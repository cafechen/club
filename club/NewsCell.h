//
//  NewsCell.h
//  pengpengtou
//
//  Created by steven on 12-12-23.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell <UIWebViewDelegate>

@property (copy, nonatomic) UIImage *pic;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *body;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, readwrite) CGFloat contentHeight;

@property (nonatomic, retain) IBOutlet UIImageView *avatarView;
@property (nonatomic, retain) IBOutlet UIWebView *bodyView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

@end
