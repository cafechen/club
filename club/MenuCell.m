//
//  MenuCell.m
//  pengpengtou
//
//  Created by steven on 12-12-23.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

@synthesize menuContent;
@synthesize menuCount;
@synthesize menuImage;
@synthesize menuTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenuImage:(UIImage *)image {
    if (![image isEqual:menuImage]) {
        menuImage = [image copy];
        self.menuImageView.image = menuImage;
    }
}

-(void)setMenuCount:(NSString *) t {
    if (![t isEqualToString:menuCount]) {
        menuCount = [t copy];
        self.menuCountLabel.text = menuCount;
    }
}

-(void)setMenuContent:(NSString *) t {
    if (![t isEqualToString:menuContent]) {
        menuContent = [t copy];
        self.menuContentLabel.text = menuContent;
    }
}

-(void)setMenuTitle:(NSString *) t {
    if (![t isEqualToString:menuTitle]) {
        menuTitle = [t copy];
        self.menuTitleLabel.text = menuTitle;
    }
}

@end
