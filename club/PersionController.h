//
//  PersionController.h
//  club
//
//  Created by steven on 13-5-10.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface PersionController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate, EGORefreshTableHeaderDelegate>{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableHeaderView *_footerRefreshView;
    BOOL _reloading;
    BOOL _isFollow;
    int _reloadSite ;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView ;
@property (nonatomic, retain) IBOutlet UILabel *personName ;
@property (nonatomic, retain) IBOutlet UIButton *actorButton ;
@property (nonatomic, retain) NSMutableArray *listData ;
@property (nonatomic, retain) UIImage *profileImage;
@property (nonatomic, retain) IBOutlet UINavigationItem *titleItem;

- (IBAction) gotoLastPageButtonAction:(id)sender;
- (IBAction) buttonPressed:(id)sender;
- (void) changeActorButtonAction;

- (void) reloadTableViewDataSource;
- (void) doneLoadingTableViewData;

@end
