//
//  frenchSFAppDelegate.m
//  frenchsf
//
//  Created by Joshua Atkin on 5/30/13.
//  Copyright (c) 2013 Joshua Atkin. All rights reserved.
//

#import "frenchSFAppDelegate.h"
#import <Parse/Parse.h>
#import "Flurry.h"
//#import "QuantcastMeasurement.h"

@implementation frenchSFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
 
    //  Parse Key Setup
    
    [Parse setApplicationId:@"AJatsygPuE1EXJhbCeswP8MkD1NGxTH5A1NxJo2v"
                  clientKey:@"MzPy8NahS9OgqV8WXI5JDdcwiYfonPHp6jpD71YY"];
    
     // Parse Analytics Setup
    
    //[PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // ****************************************************************************
    // Your Facebook application id is configured in Info.plist.
    // ****************************************************************************

    
    // Parse Facebook Configuration
    
    [PFFacebookUtils initializeFacebook];
    
    // Parse Twitter Configuration
    
    [PFTwitterUtils initializeWithConsumerKey:@"XK1wHyiBn62S3pbv19xbQ" consumerSecret:@"DjRQbd1MRaSAT1cpvwuHN1E2Zar3btQDqtYnkiSCI"];
    
    
    // Push Notification Setup
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
  
    // Flurry Configuration
    
    [Flurry startSession:@"8X9JTKN57ZBBJHMZWDTK"];
    
    
    // Quantcast Configuration
    
 //   [[QuantcastMeasurement sharedInstance] beginMeasurementSessionWithAPIKey:@"0dfytz9gaexhdng1-uxy569e8tv6bxttj" userIdentifier:nil labels:nil];
    

    
    
    
    
    return YES;
}

///notifications
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}



- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}


// Added for Facebook
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [PFFacebookUtils handleOpenURL:url];
    
    
    
    
    
}

// End of add for Facebook

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    // Added for Quantcast
  //  [[QuantcastMeasurement sharedInstance] pauseSessionWithLabels:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    // Added for Quantcast
    
  //  [[QuantcastMeasurement sharedInstance] resumeSessionWithLabels:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Add for Facebook
    
    [FBSession.activeSession handleDidBecomeActive];
    
    // End of Add for Facebook
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // Added for Facebook
    
    [FBSession.activeSession close];
    
    // End of add for Facebook
    
    
    
    // Added for Quantcast
   // [[QuantcastMeasurement sharedInstance] endMeasurementSessionWithLabels:nil];
    
}

@end
