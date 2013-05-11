//
//  ShareDetailController.m
//  club
//
//  Created by Steven on 13-5-11.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import "ShareDetailController.h"
#import "AppDelegate.h"
#import "Share.h"
#import "Cache.h"
#import "Define.h"

@interface ShareDetailController ()

@end

@implementation ShareDetailController

@synthesize avatar;
@synthesize attactment;
@synthesize body;
@synthesize title;
@synthesize time;
@synthesize userId;
@synthesize toPersion ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    self.body = appDelegate.currShare.msgBody ;
    self.title = appDelegate.currShare.msgTitle ;
    self.time = appDelegate.currShare.msgTime ;
    if(appDelegate.currShare.msgActor != nil && ![@"" isEqualToString:appDelegate.currShare.msgActor]){
        NSArray *data = [NSArray arrayWithObjects:appDelegate.currShare.msgActor, nil];
        [NSThread detachNewThreadSelector:@selector(downloadAvatarAndCache:) toTarget:self withObject:data];
    }
    if(appDelegate.currShare.msgAttach != nil && ![@"" isEqualToString:appDelegate.currShare.msgAttach]){
        NSArray *data = [NSArray arrayWithObjects:appDelegate.currShare.msgAttach, nil];
        [NSThread detachNewThreadSelector:@selector(downloadAttachAndCache:) toTarget:self withObject:data];
    }
    
    self.toolbar.frame = CGRectMake(0, ScreenHeight, ScreenWidth, _toolbar.frame.size.height);
    self.bigImageView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.bigImageView.frame.size.height + _toolbar.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction) gotoLastPageButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    [appDelegate gotoLastPage3] ;
}

- (void) downloadAvatarAndCache: (NSArray *)data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    for(int i = 0; i < appDelegate.imageCacheList.count; i++){
        Cache *cache = [appDelegate.imageCacheList objectAtIndex:i];
        if([cache.imageUrl isEqualToString:[data objectAtIndex:0]]){
            self.avatar = cache.imageCache ;
            return ;
        }
    }
    
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectAtIndex:0]]]];
    if(loadImage == nil){
        return ;
    }
    self.avatar = loadImage ;
    Cache *newCache = [[Cache alloc] init] ;
    newCache.imageCache = [loadImage copy] ;
    newCache.imageUrl = [data objectAtIndex:0] ;
    [appDelegate.imageCacheList addObject:newCache];
}

- (void) downloadAttachAndCache: (NSArray *)data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    for(int i = 0; i < appDelegate.imageCacheList.count; i++){
        Cache *cache = [appDelegate.imageCacheList objectAtIndex:i];
        if([cache.imageUrl isEqualToString:[data objectAtIndex:0]]){
            self.attactment = cache.imageCache ;
            //增加鼠标点击事件
            NSLog(@"增加鼠标点击事件") ;
            self.attachView.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
            singleTap.view.tag = (int)self.attactment;
            [self.attachView addGestureRecognizer:singleTap];
            return ;
        }
    }
    
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectAtIndex:0]]]];
    if(loadImage == nil){
        return ;
    }
    self.attactment = loadImage ;
    Cache *newCache = [[Cache alloc] init] ;
    newCache.imageCache = [loadImage copy] ;
    newCache.imageUrl = [data objectAtIndex:0] ;
    [appDelegate.imageCacheList addObject:newCache];
    
    //增加鼠标点击事件
    NSLog(@"增加鼠标点击事件") ;
    self.attachView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    singleTap.view.tag = (int)self.attactment;
    [self.attachView addGestureRecognizer:singleTap];
}

- (void) showBigImage:(id)sender
{
    NSLog(@"Show Big Image") ;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    //self.tableView.frame = CGRectMake(0, 480 - _tableView.frame.size.height, 320, _tableView.frame.size.height);
    //self.toolbar.frame = CGRectMake(0, 480 - _tableView.frame.size.height - _toolbar.frame.size.height , 320, _toolbar.frame.size.height);
    
    self.bigImageView.frame = CGRectMake(0, _toolbar.frame.size.height, ScreenWidth, ScreenHeight - _toolbar.frame.size.height);
    
    self.toolbar.frame = CGRectMake(0, 0, ScreenWidth, _toolbar.frame.size.height);
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    [NSThread detachNewThreadSelector:@selector(downloadBigImage:) toTarget:self withObject:appDelegate.currShare.msgAttach];
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (void) downloadBigImage: (NSString *)url
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    for(int i = 0; i < appDelegate.imageCacheList.count; i++){
        Cache *cache = [appDelegate.imageCacheList objectAtIndex:i];
        if([cache.imageUrl isEqualToString:url]){
            self.imageView.image = cache.imageCache ;
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            //self.imageView.image = cache.imageCache ;
            return ;
        }
    }
    self.imageView.image = [UIImage imageNamed:@"blank.png"] ;
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    self.imageView.image = loadImage ;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    Cache *newCache = [[Cache alloc] init];
    newCache.imageCache = [loadImage copy];
    newCache.imageUrl = url ;
    [appDelegate.imageCacheList addObject:newCache];
}

- (IBAction) pushPickerView:(id)sender
{
    //_groupLabel.text = _tplName ;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.6];//动画时间长度，单位秒，浮点数
    //self.pickerView.frame = CGRectMake(0, 480, 320, _pickerView.frame.size.height);
    
    //self.toolbar.frame = CGRectMake(0, 480, 320, _toolbar.frame.size.height);
    //self.tableView.frame = CGRectMake(0, 480, 320, _tableView.frame.size.height + _toolbar.frame.size.height);
    
    self.bigImageView.frame = CGRectMake(0, 480 + _toolbar.frame.size.height + 176, 320, 480 - _toolbar.frame.size.height + 176);
    self.toolbar.frame = CGRectMake(0, 480 + 176, 320, _toolbar.frame.size.height);
    
    [UIView setAnimationDelegate:self];
    // 动画完毕后调用animationFinished
    [UIView setAnimationDidStopSelector:@selector(animationFinished)];
    [UIView commitAnimations];
}

- (IBAction) saveBigImage:(id)sender
{
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector ( image:didFinishSavingWithError:contextInfo:) , nil ) ;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)image: (UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存失败！请重试。" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else  // No errors
    {
        // Show message image successfully saved
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存成功！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

-(void) animationFinished{
    NSLog(@"动画结束!");
}

@end
