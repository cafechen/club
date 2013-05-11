//
//  ShareCell.m
//  pengpengtou
//
//  Created by steven on 12-12-23.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import "ShareCell.h"

@implementation ShareCell

@synthesize avatar;
@synthesize attactment;
@synthesize body;
@synthesize title;
@synthesize time;
@synthesize userId;
@synthesize toPersion ;

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

- (void)setAvatar:(UIImage *)image {
    if (![image isEqual:avatar]) {
        avatar = [image copy];
        self.avatarView.image = avatar;
        self.avatarView.contentMode= UIViewContentModeScaleAspectFit ;
        self.avatarView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAvatar:)];
        [self.avatarView addGestureRecognizer:singtap];
    }
}

- (void)setAttactment:(UIImage *)image {
    if (![image isEqual:attactment]) {
        attactment = [image copy];
        self.attachView.image = attactment;
        self.attachView.contentMode= UIViewContentModeScaleAspectFit ;
    }
}

-(void)setTitle:(NSString *) t {
    if (![t isEqual:[NSNull null]] && ![t isEqualToString:title]) {
        title = [t copy];
        self.titleLabel.text = title;
    }
}

-(void)setBody:(NSString *) b {
    if (![b isEqual:[NSNull null]] && ![b isEqualToString:body]) {
        body = [b copy];
        self.bodyLabel.text = body;
    }
}

-(void)setTime:(NSString *) t {
    if (![t isEqual:[NSNull null]] && ![t isEqualToString:time]) {
        time = [t copy];
        self.timeLabel.text = time;
    }
}

-(void)clickAvatar:(id)sender
{
    if(!toPersion)
        return ;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    appDelegate.currUserId = [self.userId copy] ;
    [appDelegate gotoPersionPage];
}

@end
