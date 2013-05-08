//
//  NewsCell.m
//  pengpengtou
//
//  Created by steven on 12-12-23.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

@synthesize pic;
@synthesize body;
@synthesize title;
@synthesize contentHeight;

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

- (void)setPic:(UIImage *)image {
    if (![image isEqual:pic]) {
        pic = [image copy];
        self.avatarView.image = pic;
    }
}

-(void)setTitle:(NSString *) t {
    if (![t isEqualToString:title]) {
        title = [t copy];
        self.titleLabel.text = title;
    }
}

-(void)setBody:(NSString *) b {
    if (![b isEqualToString:body]) {
        body = [b copy];
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [self.bodyView loadData:data MIMEType:@"application/xhtml+xml" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:@"http://42.96.144.219/"]];
        self.bodyView.delegate = self ;
        [self.bodyView loadHTMLString:body baseURL:[NSURL URLWithString:nil]];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *) webView
{
    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    self.contentHeight = newFrame.size.height ;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newFrame.size.height + 96) ;
}


@end
