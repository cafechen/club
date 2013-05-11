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
#import "HomeController.h"
#import "PersionController.h"
#import "HTTPTools.h"
#import "NSString+URLEncoding.h"

@implementation AppDelegate

@synthesize imageCacheList ;
@synthesize currNewsGroupId ;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade] ;
    
    self.imageCacheList = [[NSMutableArray alloc] init] ;
    
    self.isLogin = NO ;
    
    //初始化页面
    self.navController1 = [[UINavigationController alloc] init] ;
    self.navController2 = [[UINavigationController alloc] init] ;
    self.navController3 = [[UINavigationController alloc] init] ;
    self.navController4 = [[UINavigationController alloc] init] ;
    [self.navController1 setNavigationBarHidden:YES animated:NO];
    [self.navController2 setNavigationBarHidden:YES animated:NO];
    [self.navController3 setNavigationBarHidden:YES animated:NO];
    [self.navController4 setNavigationBarHidden:YES animated:NO];
    LoginController *loginController = nil ;
    
    if(isIPhone5){
        loginController = [[LoginController alloc] initWithNibName:@"LoginController_iphone5" bundle:nil];
    }else{
        loginController = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    }
    
    [self.navController1 pushViewController:loginController animated:YES] ;
    
    //显示首页
    self.window.rootViewController = self.navController1 ;
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
    [self.navController1 pushViewController:signUpController animated:YES] ;
    
    self.window.rootViewController = self.navController1;
    NSLog(@"Goto SignUp Page End") ;
}

- (void)gotoIndexPage
{
    NSLog(@"Goto Index Page Start") ;
    
    //index包含三个页面 index tline home
    
    IndexController *indexController = nil ;
    
    if(isIPhone5){
        indexController = [[IndexController alloc] initWithNibName:@"IndexController_iphone5" bundle:nil];
    }else{
        indexController = [[IndexController alloc] initWithNibName:@"IndexController" bundle:nil];
    }
    [self.navController2 pushViewController:indexController animated:YES] ;
    
    TLineController *tlineController = nil ;
    if(isIPhone5){
        tlineController = [[TLineController alloc] initWithNibName:@"TLineController_iphone5" bundle:nil];
    }else{
        tlineController = [[TLineController alloc] initWithNibName:@"TLineController" bundle:nil];
    }
    [self.navController3 pushViewController:tlineController animated:YES] ;
    
    HomeController *homeController = nil ;
    if(isIPhone5){
        homeController = [[HomeController alloc] initWithNibName:@"HomeController_iphone5" bundle:nil];
    }else{
        homeController = [[HomeController alloc] initWithNibName:@"HomeController" bundle:nil];
    }
    [self.navController4 pushViewController:homeController animated:YES] ;
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    self.tabBarController.viewControllers = @[self.navController2, self.navController3, self.navController4];
    
    self.window.rootViewController = self.tabBarController;
    
    //[self.navController pushViewController:tabBarController animated:YES] ;
    
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
    [self.navController2 pushViewController:newsController animated:YES] ;
    
    self.window.rootViewController = self.tabBarController;
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
    [self.navController3 pushViewController:shareController animated:YES] ;
    
    self.window.rootViewController = self.tabBarController;
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
    [self.navController2 pushViewController:tlineController animated:YES] ;
    
    self.window.rootViewController = self.tabBarController;
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
    [self.navController2 pushViewController:newsDetailController animated:YES] ;
    
    self.window.rootViewController = self.tabBarController;
    NSLog(@"Goto News Detail Page End") ;
}

- (void) gotoLoginPage
{
    NSLog(@"Goto Login Page Start") ;
    LoginController *loginController = nil ;
    if(isIPhone5){
        loginController = [[LoginController alloc] initWithNibName:@"LoginController_iphone5" bundle:nil];
    }else{
        loginController = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    }
    [self.navController1 pushViewController:loginController animated:YES] ;
    
    self.window.rootViewController = self.navController1;
    NSLog(@"Goto Login Page End") ;
}

- (void)gotoLastPage1
{
    NSLog(@"Goto Last Page Start") ;
    [self.navController1 popViewControllerAnimated:YES];
    
    self.window.rootViewController = self.navController1;
    NSLog(@"Goto Last Page End") ;
}

- (void)gotoLastPage2
{
    NSLog(@"Goto Last Page Start") ;
    [self.navController2 popViewControllerAnimated:YES];
    self.window.rootViewController = self.tabBarController;
    NSLog(@"Goto Last Page End") ;
}

- (void)gotoLastPage3
{
    NSLog(@"Goto Last Page Start") ;
    [self.navController3 popViewControllerAnimated:YES];
    self.window.rootViewController = self.tabBarController;
    NSLog(@"Goto Last Page End") ;
}

- (void)gotoLastTLPage
{
    NSLog(@"Goto Last TL Page Start") ;
    [self.navController3 popViewControllerAnimated:YES];
    self.window.rootViewController = self.tabBarController;
    UIViewController *currController = [self.navController3.viewControllers lastObject] ;
    [currController viewDidLoad] ;
    NSLog(@"Goto Last TL Page End") ;
}

- (void)gotoPersionPage
{
    NSLog(@"Goto Persion Page Start") ;
    PersionController *persionController = nil ;
    if(isIPhone5){
        persionController = [[PersionController alloc] initWithNibName:@"PersionController_iphone5" bundle:nil];
    }else{
        persionController = [[PersionController alloc] initWithNibName:@"PersionController" bundle:nil];
    }
    [self.navController3 pushViewController:persionController animated:YES] ;
    
    self.window.rootViewController = self.tabBarController;
    NSLog(@"Goto Persion Detail Page End") ;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.window.rootViewController = self.tabBarController;
    if(buttonIndex == 0){
        [self.window.rootViewController viewDidLoad] ;
        return ;
    }else if(buttonIndex == 1){
        [NSThread detachNewThreadSelector:@selector(sendNSync) toTarget:self withObject:nil];
    }
}

@end
