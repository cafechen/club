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

@interface NewsController ()

@end

@implementation NewsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableViewCellsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    self.tableData = [self getTableLists];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
    
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
    
    // 該行要顯示的內容
    NSLog(@"#### heightForRowAtIndexPath") ;
    if(self.tableViewCellsArray.count == 0){
        NSLog(@"#### NULL") ;
        return 202 ;
    }else{
        NewsCell *cell = [self.tableViewCellsArray objectAtIndex:indexPath.row] ;
        NSLog(@"#### %f", cell.contentHeight) ;
        return cell.contentHeight + 96;
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
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
    
    [cell.textLabel setContentMode:UIViewContentModeRight] ;
    
    NSURL *url = [NSURL URLWithString:[dict objectForKey:@"pic"]];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
    cell.body = [dict objectForKey:@"content"];
    cell.pic = image ;
    cell.title = [dict objectForKey:@"title"];
    cell.myTableView = tableView;
    [self.tableViewCellsArray addObject:cell] ;
    
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

@end
