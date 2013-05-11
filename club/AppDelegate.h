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
@property (strong, nonatomic) UINavigationController *navController1;
@property (strong, nonatomic) UINavigationController *navController2;
@property (strong, nonatomic) UINavigationController *navController3;
@property (strong, nonatomic) UINavigationController *navController4;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (nonatomic, retain) NSMutableArray *imageCacheList;
@property (nonatomic, retain) NSString *currNewsGroupId;
@property (nonatomic, retain) NSDictionary *currNewsDetail;
@property (nonatomic, readwrite) BOOL isLogin;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *authorId;
@property (nonatomic, retain) NSString *nickname;
@property (nonatomic, retain) NSString *currUserId;

- (void)gotoSignUpPage ;
- (void)gotoLastPage1 ;
- (void)gotoLastPage2 ;
- (void)gotoLastPage3 ;
- (void)gotoIndexPage ;
- (void)gotoNewsPage ;
- (void)gotoNewsDetailPage ;
- (void)gotoSharePage ;
- (void)gotoTLinePage ;
- (void)gotoLastTLPage ;
- (void)gotoLoginPage ;
- (void)gotoPersionPage ;

@end
