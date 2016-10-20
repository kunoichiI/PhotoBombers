//
//  WMYAppDelegate.m
//  Photo Bombers
//
//  Created by Mingyuan Wang on 6/24/15.
//  Copyright (c) 2015 Mingyuan Wang. All rights reserved.
//

#import "WMYAppDelegate.h"
#import "WMYPhotosViewController.h"

#import <SSkeychain/SSKeychain.h>
#import <SimpleAuth/SimpleAuth.h>

@implementation WMYAppDelegate
- (void)customizeAppearance {
    // set the color of UISearchbar in WMYPhotosViewController
    UIColor *barTintColor = [UIColor redColor];
    [[UISearchBar appearance]setBarTintColor:barTintColor];
    
    self.window.tintColor = [UIColor redColor];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // specify how the keychain can be accessed
    [SSKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlocked];
    
 
    
    SimpleAuth.configuration[@"instagram"] = @{ @"client_id" : @"33be8e59e9dd43b6a5f368da16c2d4bf",
                                                SimpleAuthRedirectURIKey : @"http://photobombers://auth/instagram"
                                                 };
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self customizeAppearance];
    
    WMYPhotosViewController *photosViewController = [[WMYPhotosViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:photosViewController];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // Set navigation Bar title color using the apprearance proxy
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:198.0/ 255.0 green:26.0/ 255.0 blue:131.0/255.0 alpha:1.0]];
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackOpaque];

    
    
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
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

@end
