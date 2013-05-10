//
//  HomeController.h
//  club
//
//  Created by steven on 13-5-10.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface HomeController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIAlertViewDelegate, EGORefreshTableHeaderDelegate>{
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

- (IBAction) buttonPressed:(id)sender;
- (void) changeActorButtonAction;

- (void) reloadTableViewDataSource;
- (void) doneLoadingTableViewData;

@end
