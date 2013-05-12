//
//  NewsDetailController.m
//  club
//
//  Created by Steven on 13-5-9.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import "NewsDetailController.h"
#import "AppDelegate.h"
#import "Cache.h"

@interface NewsDetailController ()

@end

@implementation NewsDetailController

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
    // Do any additional setup after loading the view from its nib.
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    if([appDelegate.currNewsDetail objectForKey:@"pic"] != nil && ![@"" isEqualToString: [appDelegate.currNewsDetail objectForKey:@"pic"]]){
        
        NSArray *data = [NSArray arrayWithObjects:[appDelegate.currNewsDetail objectForKey:@"pic"], self, nil];
        
        [NSThread detachNewThreadSelector:@selector(downloadImageAndCache:) toTarget:self withObject:data] ;
        
        //cell.menuImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.menuPic]]] ;
    }else{
        self.imageView.image = [UIImage imageNamed:@"Icon.png"] ;
    }
    
    self.titleLabel.text = [appDelegate.currNewsDetail objectForKey:@"title"];
    NSData *data = [[appDelegate.currNewsDetail objectForKey:@"content"] dataUsingEncoding:NSUTF8StringEncoding];
    [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:@"http://42.96.144.219/"]];
    self.webView.delegate = self ;
}

- (void)webViewDidFinishLoad:(UIWebView *) webView
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) gotoLastPageButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    [appDelegate gotoLastPage2] ;
}

- (void) downloadImageAndCache: (NSArray *)data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    for(int i = 0; i < appDelegate.imageCacheList.count; i++){
        Cache *cache = [appDelegate.imageCacheList objectAtIndex:i];
        if([cache.imageUrl isEqualToString:[data objectAtIndex:0]]){
            self.imageView.image = cache.imageCache ;
            return ;
        }
    }
    
    self.imageView.image = [UIImage imageNamed:@"Icon.png"];
    
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectAtIndex:0]]]];
    if(loadImage == nil){
        return ;
    }
    
    self.imageView.image = loadImage ;
    Cache *newCache = [[Cache alloc] init] ;
    newCache.imageCache = [loadImage copy] ;
    newCache.imageUrl = [data objectAtIndex:0] ;
    [appDelegate.imageCacheList addObject:newCache];
}

@end
