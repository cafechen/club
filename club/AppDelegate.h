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
@property (nonatomic, readwrite) BOOL isLogin;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *authorId;
@property (nonatomic, retain) NSString *nickname;

- (void)gotoSignUpPage ;
- (void)gotoLastPage ;
- (void)gotoIndexPage ;
- (void)gotoNewsPage ;
- (void)gotoNewsDetailPage ;
- (void)gotoRootPage ;
- (void)gotoSharePage ;
- (void)gotoTLinePage ;
- (void)gotoLastTLPage ;

@end
