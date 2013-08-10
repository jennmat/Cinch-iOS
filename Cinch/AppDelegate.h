//
//  AppDelegate.h
//  Cinch
//
//  Created by Matt on 7/22/13.
//  Copyright (c) 2013 cinch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouchDatabase;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic) CouchDatabase * database;

@end
