//
//  BNAppDelegate.m
//  Brutto-Netto-Rechner
//
//  Created by Pavel Ermolin on 02.09.14.
//  Copyright (c) 2014 QSoft-Factory | Pavel Ermolin. All rights reserved.
//

#import "BNAppDelegate.h"
#import "BNGrossNetWageViewController.h"
#import "BNGrossNetWagePresenter.h"
#import "BNGrossNetWageInteractor.h"
#import "BNWageDataManager.h"
#import "BNCoreDataStore.h"
#import "BNSettingsViewController.h"

@interface BNAppDelegate ()

@end

@implementation BNAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [BNCoreDataStore setupCoreDataStack];
    self.window = [self configureWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];

    return YES;
}

- (UIWindow *)configureWindow:(UIWindow *)window {
    window.rootViewController = [self createRootViewController];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    return window;
}

- (UIViewController *)createRootViewController {
    // Create and set dependencies
    
    // Main View:
    // maybe it would be better to extract it to a some Dependencies-Manager-Class
    BNGrossNetWageViewController *wageCalculatorView = [[BNGrossNetWageViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *wageCalculatorNavController = [[UINavigationController alloc] initWithRootViewController:wageCalculatorView];
    BNGrossNetWagePresenter *presenter = [[BNGrossNetWagePresenter alloc] init];
    // Needs an instance of a data store
    BNWageDataManager *dataManager = [[BNWageDataManager alloc] init];
    [dataManager setDataStore:[[BNCoreDataStore alloc] init]];
    // Needs an instance of a data manager
    BNGrossNetWageInteractor *interactor = [[BNGrossNetWageInteractor alloc] initWithDataManager:dataManager];
    wageCalculatorView.presenter = presenter;
    presenter.view = wageCalculatorView;
    presenter.interactor = interactor;
    interactor.output = presenter;
    
    // Settings View:
    BNSettingsViewController *settingsView = [[BNSettingsViewController alloc] init];
    UINavigationController *settingsNavController = [[UINavigationController alloc] initWithRootViewController:settingsView];
    
    // Tab Bar Navigation
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    [tabBar setViewControllers:@[wageCalculatorNavController, settingsNavController]];
    
    
    return tabBar;
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
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
