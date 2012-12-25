//
//  AppDelegate.m
//  iOSBackgroundTest
//
//  Created by Steve on 12/12/25.
//  Copyright (c) 2012年 Steve. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
@interface AppDelegate () {
    BOOL mFlag;
}
@end
@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if (!mFlag) {
        mFlag = YES;
        
        // 時間到了會執行這個block
        __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
//            [application endBackgroundTask:bgTask];
//            bgTask = UIBackgroundTaskInvalid;
//            mFlag = NO;
        }];
        
        // 在背景執行一些東西...
        // 在這邊我用一個無窮迴圈來測試
        // backgroundTimeRemaining 會開始倒數10分鐘
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // run something background
            NSLog(@"App in BG!");
            int i = 0;
            while (YES) {
                NSString *msg = nil;
                if ([UIApplication sharedApplication].backgroundTimeRemaining <= 0) {
                    msg = @"App STILL in BG, backgroundTimeRemaining ";

                } else {
                    msg = @"App in BG, backgroundTimeRemaining ";
                }
                
                
                NSLog(@"%@%f sec", msg, [UIApplication sharedApplication].backgroundTimeRemaining);
                [UIApplication sharedApplication].applicationIconBadgeNumber = ++i;
                [NSThread sleepForTimeInterval:0.1];
                
            }
            
            // when finish, call this method
            [application endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
            mFlag = NO;
        });
    }
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
