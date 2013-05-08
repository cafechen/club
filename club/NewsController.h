//
//  NewsController.h
//  club
//
//  Created by steven on 13-5-8.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *tableData ;
@property (nonatomic, retain) NSMutableArray *tableViewCellsArray ;

- (IBAction) gotoLastPageButtonAction:(id)sender;

@end
