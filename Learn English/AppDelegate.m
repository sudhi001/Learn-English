//
//  AppDelegate.m
//  Learn English
//
//  Created by Sudhi.S on 26/12/14.
//  Copyright (c) 2014 Maxlogix. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MXLibraryAPI sharedInstance];
    [MXSpeech sharedInstance];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          nil]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor paperColorOrange700]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    NSDictionary * navBarTitleTextAttributes =
    @{ NSForegroundColorAttributeName : [UIColor whiteColor],
       NSFontAttributeName            : [UIFont systemFontOfSize:16] };
    
    [[UINavigationBar appearance] setTitleTextAttributes:navBarTitleTextAttributes];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
