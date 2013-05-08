//
//  IndexController.m
//  club
//
//  Created by steven on 13-5-7.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import "IndexController.h"
#import "HTTPTools.h"
#import "MenuCell.h"
#import "Menu.h"
#import "JSONKit.h"
#import "Cache.h"
#import "AppDelegate.h"

@interface IndexController ()

@end

@implementation IndexController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - 65, self.view.frame.size.width, 65)];
		view.delegate = self;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"111"]];
        imgView.frame = view.bounds;
        view.backGroundView = imgView;
        view.backgroundColor = [UIColor clearColor];
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
        //  update the last update date
        [_refreshHeaderView refreshLastUpdatedDate];
        [self.view setNeedsLayout];
        [self.tableView setNeedsLayout];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableData = [self getTableLists];
    [self.tableView reloadData];
}

- (NSMutableArray *)getTableLists
{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    //提交请求
    NSString *response = [HTTPTools sendRequestUri:@"/api/getcateslist" Params:[NSDictionary dictionaryWithObjectsAndKeys:nil]] ;
    
    if(response == nil){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络异常，请检查网络！" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return result ;
    }
    
    NSArray *jsonArray = [response objectFromJSONString];
    
    if(jsonArray != nil){
        for(int i = 0; i < jsonArray.count; i++){
            Menu *m = [[Menu alloc] init];
            NSDictionary *groupCell = [jsonArray objectAtIndex:i] ;
            m.menuGroupId = [groupCell objectForKey: @"id"];
            m.menuName = [groupCell objectForKey: @"name"];
            m.menuPic = [groupCell objectForKey: @"pic"];
            if((NSNull *)m.menuPic == [NSNull null]){
                m.menuPic = @"" ;
            }
            [result addObject:m];
        }
    }
    
    return result ;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60 ;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    
    Menu *menu = (Menu *)[self.tableData objectAtIndex:row];
    
    NSString *response = [HTTPTools sendRequestUri:@"/api/getgrouplist" Params:[NSDictionary dictionaryWithObjectsAndKeys:menu.menuGroupId, @"id",nil]] ;
    
    NSArray *jsonArray = [response objectFromJSONString];
    
    menu.menuArray = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < jsonArray.count; i++){
        Menu *gm = [[Menu alloc] init];
        NSDictionary *info = [jsonArray objectAtIndex:i] ;
        gm.menuGroupId = [info objectForKey: @"id"];
        gm.menuName = @"" ; //[info objectForKey: @"nickname"];
        gm.menuContent = [info objectForKey: @"fullname"];
        gm.menuPic = [info objectForKey: @"mini_logo"];
        if((NSNull *)gm.menuPic == [NSNull null]){
            gm.menuPic = @"" ;
        }
        [menu.menuArray addObject:gm];
    }
    
    self.currMenu = menu ;
    
    [self showAWSheet];
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"MenuCellIdentifier";
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:
                      TableSampleIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSUInteger row = [indexPath row];
    Menu *m = (Menu *)[self.tableData objectAtIndex:row];
    cell.menuTitle = [NSString stringWithFormat:@"%@", m.menuName] ;

    if(![@"" isEqualToString: m.menuPic] && m.menuPic != nil){
        
        NSArray *data = [NSArray arrayWithObjects:m.menuPic, cell, nil];
        
        [NSThread detachNewThreadSelector:@selector(downloadImageMenuCell:) toTarget:self withObject:data] ;
        
        //cell.menuImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.menuPic]]] ;
    }else{
        cell.menuImage = [UIImage imageNamed:@"Icon.png"] ;
    }
    
    //CGFloat contentWidth = 224 ;
    UIFont *font = [UIFont systemFontOfSize:16];
    
    cell.menuContentLabel.numberOfLines = 1;
    
    cell.menuContentLabel.font = font;
    
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

- (void) downloadImageMenuCell: (NSArray *)data
{
    NSLog(@"data size %d %@", data.count, [data objectAtIndex:0]) ;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    for(int i = 0; i < appDelegate.imageCacheList.count; i++){
        Cache *cache = [appDelegate.imageCacheList objectAtIndex:i];
        if([cache.imageUrl isEqualToString:[data objectAtIndex:0]]){
            MenuCell *cell = [data objectAtIndex:1] ;
            cell.menuImage = cache.imageCache ;
            return ;
        }
    }
    
    MenuCell *cell = [data objectAtIndex:1] ;
    [cell setMenuImage:[UIImage imageNamed:@"Icon.png"]];
    UIImage *loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectAtIndex:0]]]];
    if(loadImage == nil){
        return ;
    }
    cell.menuImage = loadImage ;
    Cache *newCache = [[Cache alloc] init] ;
    newCache.imageCache = [loadImage copy] ;
    newCache.imageUrl = [data objectAtIndex:0] ;
    [appDelegate.imageCacheList addObject:newCache];
}

- (void) downloadImageAWActionSheetCell: (NSArray *)data
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    
    for(int i = 0; i < appDelegate.imageCacheList.count; i++){
        Cache *cache = [appDelegate.imageCacheList objectAtIndex:i];
        if([cache.imageUrl isEqualToString:[data objectAtIndex:0]]){
            AWActionSheetCell *cell = [data objectAtIndex:1] ;
            [[cell iconView] setImage:cache.imageCache];
            return ;
        }
    }
    
    UIImage *loadImage = nil ;
    AWActionSheetCell *cell = [data objectAtIndex:1] ;
    [[cell iconView] setImage:[UIImage imageNamed:@"Icon.png"]];
    loadImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectAtIndex:0]]]];
    if(loadImage == nil){
        return ;
    }
    [[cell iconView] setImage:loadImage];
    Cache *newCache = [[Cache alloc] init] ;
    newCache.imageCache = [loadImage copy] ;
    newCache.imageUrl = [data objectAtIndex:0] ;
    [appDelegate.imageCacheList addObject:newCache];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    //[_footerRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	self.tableData = [self getTableLists];
    [self.tableView reloadData];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < -1) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    /*
     else if (_footerRefreshView)
     {
     [_footerRefreshView egoRefreshScrollViewDidScroll:scrollView];
     }
     */
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.y < -1) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    /*
     else if (_footerRefreshView)
     {
     [_footerRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
     }
     */
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)showAWSheet
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet showInView:self.view];
}

-(int)numberOfItemsInActionSheet
{
    return self.currMenu.menuArray.count;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    
    Menu *m = [self.currMenu.menuArray objectAtIndex:index];
    
    if([@"" isEqualToString:m.menuPic]){
        [[cell iconView] setImage:[UIImage imageNamed:@"Icon.png"]];
    }else{
        
        NSArray *data = [NSArray arrayWithObjects:m.menuPic, cell, nil];
        
        [NSThread detachNewThreadSelector:@selector(downloadImageAWActionSheetCell:) toTarget:self withObject:data] ;
        
        //[[cell iconView] setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.menuPic]]]];
    }
    [[cell titleLabel] setText:[NSString stringWithFormat:@"%@",m.menuName]];
    
    [[cell titleBody] setText:[NSString stringWithFormat:@"%@",m.menuContent]];
    
    cell.index = index;
    
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    Menu *m = [self.currMenu.menuArray objectAtIndex:index];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
    appDelegate.currNewsGroupId = [m.menuGroupId copy] ;
    [appDelegate gotoNewsPage] ;
}

@end
