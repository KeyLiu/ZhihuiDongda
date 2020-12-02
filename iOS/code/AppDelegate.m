//
//  AppDelegate.m
//  code
//
//  Created by KeyLiu on 2020/9/25.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ScanViewController.h"

@interface AppDelegate ()



@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *rootNavgationController = [[UINavigationController alloc] initWithRootViewController:[ScanViewController new]];
    self.window.rootViewController = rootNavgationController;
    
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:99/255.0 green:173/255.0 blue:252/255.0 alpha:1];
    
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle
@end
