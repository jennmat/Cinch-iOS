//
//  AppDelegate.m
//  Cinch
//
//  Created by Matt on 7/22/13.
//  Copyright (c) 2013 cinch. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "MenuViewController.h"

#import <CouchCocoa/CouchCocoa.h>
#import <CouchCocoa/CouchTouchDBServer.h>


@implementation AppDelegate

@synthesize database;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    CouchTouchDBServer* server = [CouchTouchDBServer sharedInstance];
    self.database = [server databaseNamed: @"starter" withBackingDatabase:@"https://jennmat:I83ertnk@jennmat.cloudant.com/cinch-starter"];
    NSError* error;
    
    [self.database ensureCreated: &error];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //MyTestViewController *viewController1 = [[MyTestViewController alloc] initWithNibName:@"MyTestViewController" bundle:nil];
    
    MenuViewController* vc = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    
    CouchDesignDocument* design = [database designDocumentWithName: @"all-menu-definitions"];
    [design defineViewNamed: @"by-perspective" mapBlock: MAPBLOCK({}) version:@"1.0"];
    
    CouchQuery* query = [[database designDocumentWithName:@"all-menu-definitions"] queryViewNamed:@"by-perspective"];
    for(CouchQueryRow* row in query.rows ){
        CouchDocument* doc = row.document;
        NSArray* items = [doc.properties objectForKey: @"items"];
        
        [vc setItems:items];
    }
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav];
    self.window.rootViewController = self.tabBarController;
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
