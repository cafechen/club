//
//  MenuCell.h
//  pengpengtou
//
//  Created by steven on 12-12-23.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell <UITextViewDelegate>

@property (copy, nonatomic) UIImage *menuImage;
@property (copy, nonatomic) NSString *menuTitle;
@property (copy, nonatomic) NSString *menuContent;
@property (copy, nonatomic) NSString *menuCount;

@property (nonatomic, retain) IBOutlet UIImageView *menuImageView;
@property (nonatomic, retain) IBOutlet UILabel *menuTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *menuContentLabel;
@property (nonatomic, retain) IBOutlet UILabel *menuCountLabel;

@end
