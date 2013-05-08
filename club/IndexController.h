//
//  IndexController.h
//  club
//
//  Created by steven on 13-5-7.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AWActionSheet.h"
#import "EGORefreshTableHeaderView.h"
#import "Menu.h"

@interface IndexController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, EGORefreshTableHeaderDelegate,UIActionSheetDelegate,AWActionSheetDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableHeaderView *_footerRefreshView;
    BOOL _reloading;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tableData ;
@property (nonatomic, retain) Menu *currMenu ;

- (void) reloadTableViewDataSource;
- (void) doneLoadingTableViewData;

@end
