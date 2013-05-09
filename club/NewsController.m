//
//  NewsController.m
//  club
//
//  Created by steven on 13-5-8.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import "NewsController.h"
#import "AppDelegate.h"
#import "HTTPTools.h"
#import "JSONKit.h"
#import "NewsCell.h"
#import "Cache.h"

@interface NewsController ()

@end

@implementation NewsController

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
    [super viewDidLoad] ;
    
    self.tableData = [self getTableLists];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    [self.tableView reloadData] ;
}

- (NSMutableArray *)getTableLists
{
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    NSMutableArray *result = nil ;
    
    //提交请求
    NSString *response = [HTTPTools sendRequestUri:@"/api/getnewslists" Params:[NSDictionary dictionaryWithObjectsAndKeys:appDelegate.currNewsGroupId, @"id", nil]] ;
    
    if(response == nil){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络异常，请检查网络！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return result ;
    }
    
    result = [response objectFromJSONString];
    
    return result ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) gotoLastPageButtonAction:(id)sender
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    [appDelegate gotoLastPage] ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80 ;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    NSUInteger row = [indexPath row];
    
    appDelegate.currNewsDetail = (NSDictionary *)[self.tableData objectAtIndex:row];
    
    [appDelegate gotoNewsDetailPage] ;
    
    return nil ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    
    NSDictionary *dict = (NSDictionary *)[self.tableData objectAtIndex:row];
    
    static NSString *TableSampleIdentifier = @"NewsCellIdentifier";
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:
                      TableSampleIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if([dict objectForKey:@"pic"] != nil && ![@"" isEqualToString: [dict objectForKey:@"pic"]]){
        
        NSArray *data = [NSArray arrayWithObjects:[dict objectForKey:@"pic"], cell, nil];
        
        [NSThread detachNewThreadSelector:@selector(downloadImageAndCache:) toTarget:self withObject:data] ;
        
        //cell.menuImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.menuPic]]] ;
    }else{
        cell.pic = [UIImage imageNamed:@"Icon.png"] ;
    }
    
    cell.title = [dict objectForKey:@"title"];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void) downloadImageAndCache: (NSArray *)data
{
    NSLog(@"data size %d %@", data.count, [data objectAtIndex:0]) ;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    for(int i = 0; i < appDelegate.imageCacheList.count; i++){
        Cache *cache = [appDelegate.imageCacheList objectAtIndex:i];
        if([cache.imageUrl isEqualToString:[data objectAtIndex:0]]){
            NewsCell *cell = [data objectAtIndex:1] ;
            cell.pic = cache.imageCache ;
            return ;
        }
    }
    
    NewsCell *cell = [data objectAtIndex:1] ;
    [cell setPic:[UIImage imageNamed:@"Icon.png"]];
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectAtIndex:0]]]];
    if(loadImage == nil){
        return ;
    }
    cell.pic = loadImage ;
    Cache *newCache = [[Cache alloc] init] ;
    newCache.imageCache = [loadImage copy] ;
    newCache.imageUrl = [data objectAtIndex:0] ;
    [appDelegate.imageCacheList addObject:newCache];
}


@end
