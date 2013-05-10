//
//  TLineController.h
//  pengpengtou
//
//  Created by steven on 12-12-9.
//  Copyright (c) 2012年 steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "AppDelegate.h"

@class AppDelegate ;

@interface TLineController : UIViewController <UITableViewDelegate, EGORefreshTableHeaderDelegate,UITableViewDataSource>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableHeaderView *_footerRefreshView;
    BOOL _reloading;
    int _reloadSite;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *listData ;

@property (nonatomic, retain) NSString *selected ;
@property (nonatomic, retain) NSString *tabName ;
@property (nonatomic, retain) NSString *templateId ;
@property (nonatomic, retain) NSString *classId ;

- (IBAction) gotoLastPageButtonAction:(id)sender;
- (IBAction) gotoSharePageButtonAction:(id)sender;
- (void) reloadTableViewDataSource;
- (void) doneLoadingTableViewData;

@end
