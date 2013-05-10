//
//  AppDelegate.m
//  club
//
//  Created by steven on 13-4-28.
//  Copyright (c) 2013年 ibm. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "SignUpController.h"
#import "IndexController.h"
#import "NewsController.h"
#import "NewsDetailController.h"
#import "Define.h"
#import "ShareController.h"
#import "TLineController.h"

@implementation AppDelegate

@synthesize imageCacheList ;
@synthesize currNewsGroupId ;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade] ;
    
    self.imageCacheList = [[NSMutableArray alloc] init] ;
    
    self.isLogin = NO ;
    
    //初始化投注页面
    self.navController = [[UINavigationController alloc] init] ;
    [self.navController setNavigationBarHidden:YES animated:NO];
    LoginController *loginController = nil ;
    if(isIPhone5){
        loginController = [[LoginController alloc] initWithNibName:@"LoginController_iphone5" bundle:nil];
    }else{
        loginController = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    }
    
    /*
    self.navController = [[UINavigationController alloc] init] ;
    [self.navController setNavigationBarHidden:YES animated:NO];
    IndexController *indexController = nil ;
    if(isIPhone5){
        indexController = [[IndexController alloc] initWithNibName:@"IndexController_iphone5" bundle:nil];
    }else{
        indexController = [[IndexController alloc] initWithNibName:@"IndexController" bundle:nil];
    }
    */
    
    self.window.rootViewController = loginController;
    [self.navController pushViewController:loginController animated:YES] ;
    
    //显示首页
    self.window.rootViewController = self.navController ;
    [self.window makeKeyAndVisible];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)gotoSignUpPage
{
    NSLog(@"Goto SignUp Page Start") ;
    SignUpController *signUpController = nil ;
    if(isIPhone5){
        signUpController = [[SignUpController alloc] initWithNibName:@"SignUpController_iphone5" bundle:nil];
    }else{
        signUpController = [[SignUpController alloc] initWithNibName:@"SignUpController" bundle:nil];
    }
    [self.navController pushViewController:signUpController animated:YES] ;
    NSLog(@"Goto SignUp Page End") ;
}

- (void)gotoIndexPage
{
    NSLog(@"Goto Index Page Start") ;
    IndexController *indexController = nil ;
    if(isIPhone5){
        indexController = [[IndexController alloc] initWithNibName:@"IndexController_iphone5" bundle:nil];
    }else{
        indexController = [[IndexController alloc] initWithNibName:@"IndexController" bundle:nil];
    }
    [self.navController pushViewController:indexController animated:YES] ;
    NSLog(@"Goto Index Page End") ;
}

- (void)gotoNewsPage
{
    NSLog(@"Goto News Page Start") ;
    NewsController *newsController = nil ;
    if(isIPhone5){
        newsController = [[NewsController alloc] initWithNibName:@"NewsController_iphone5" bundle:nil];
    }else{
        newsController = [[NewsController alloc] initWithNibName:@"NewsController" bundle:nil];
    }
    [self.navController pushViewController:newsController animated:YES] ;
    NSLog(@"Goto News Page End") ;
}

- (void)gotoSharePage
{
    NSLog(@"Goto Share Page Start") ;
    ShareController *shareController = nil ;
    if(isIPhone5){
        shareController = [[ShareController alloc] initWithNibName:@"ShareController_iphone5" bundle:nil];
    }else{
        shareController = [[ShareController alloc] initWithNibName:@"ShareController" bundle:nil];
    }
    [self.navController pushViewController:shareController animated:YES] ;
    NSLog(@"Goto Share Page End") ;
}

- (void)gotoTLinePage
{
    NSLog(@"Goto TLine Page Start") ;
    TLineController *tlineController = nil ;
    if(isIPhone5){
        tlineController = [[TLineController alloc] initWithNibName:@"TLineController_iphone5" bundle:nil];
    }else{
        tlineController = [[TLineController alloc] initWithNibName:@"TLineController" bundle:nil];
    }
    [self.navController pushViewController:tlineController animated:YES] ;
    NSLog(@"Goto TLine Page End") ;
}

- (void)gotoNewsDetailPage
{
    NSLog(@"Goto News Detail Page Start") ;
    NewsDetailController *newsDetailController = nil ;
    if(isIPhone5){
        newsDetailController = [[NewsDetailController alloc] initWithNibName:@"NewsDetailController_iphone5" bundle:nil];
    }else{
        newsDetailController = [[NewsDetailController alloc] initWithNibName:@"NewsDetailController" bundle:nil];
    }
    [self.navController pushViewController:newsDetailController animated:YES] ;
    NSLog(@"Goto News Detail Page End") ;
}

- (void) gotoRootPage
{
    NSLog(@"Goto Root Page Start") ;
    [self.navController popToRootViewControllerAnimated:YES];
    UIViewController *currController = [self.navController.viewControllers lastObject] ;
    [currController viewDidLoad] ;
    NSLog(@"Goto Root Page End") ;
}

- (void)gotoLastPage
{
    NSLog(@"Goto Last Page Start") ;
    [self.navController popViewControllerAnimated:YES];
    NSLog(@"Goto Last Page End") ;
}

- (void)gotoLastTLPage
{
    NSLog(@"Goto Last Page Start") ;
    [self.navController popViewControllerAnimated:YES];
    UIViewController *currController = [self.navController.viewControllers lastObject] ;
    [currController viewDidLoad] ;
    NSLog(@"Goto Last Page End") ;
}

@end
