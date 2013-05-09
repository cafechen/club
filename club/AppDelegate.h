//
//  AppDelegate.h
//  club
//
//  Created by steven on 13-4-28.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navController;
@property (nonatomic, retain) NSMutableArray *imageCacheList;
@property (nonatomic, retain) NSString *currNewsGroupId;
@property (nonatomic, retain) NSDictionary *currNewsDetail;

- (void)gotoSignUpPage ;
- (void)gotoLastPage ;
- (void)gotoIndexPage ;
- (void)gotoNewsPage ;
- (void)gotoNewsDetailPage ;

@end
