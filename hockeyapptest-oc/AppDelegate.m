//
//  AppDelegate.m
//  hockeyapptest-oc
//
//  Created by Patrick Laplante on 8/19/18.
//  Copyright © 2018 Patrick Laplante. All rights reserved.
//

#import "AppDelegate.h"
@import HockeySDK;
@import CocoaLumberjack;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSString *)userIDForHockeyManager:(BITHockeyManager *)hockeyManager componentManager:(BITHockeyBaseManager *)componentManager {
    if (componentManager == hockeyManager.feedbackManager) {
        return [NSString stringWithFormat:@"Feedback account=%@  device=%@", @"foo", @"bar"];
    } else if (componentManager == hockeyManager.crashManager) {
        return [NSString stringWithFormat:@"Feedback account=%@  device=%@", @"foo", @"bar"];
    } else {
        return nil;
    }
}

// get the log content with a maximum byte size
- (NSString *) getLogFilesContentWithMaxSize:(NSInteger)maxSize {
    NSMutableString *description = [NSMutableString string];
    
    NSArray *sortedLogFileInfos = [[_fileLogger logFileManager] sortedLogFileInfos];
    NSInteger count = [sortedLogFileInfos count];
    
    // we start from the last one
    for (NSInteger index = count - 1; index >= 0; index--) {
        DDLogFileInfo *logFileInfo = [sortedLogFileInfos objectAtIndex:index];
        
        NSData *logData = [[NSFileManager defaultManager] contentsAtPath:[logFileInfo filePath]];
        if ([logData length] > 0) {
            NSString *result = [[NSString alloc] initWithBytes:[logData bytes]
                                                        length:[logData length]
                                                      encoding: NSUTF8StringEncoding];
            
            [description appendString:result];
        }
    }
    
    if ([description length] > maxSize) {
        description = (NSMutableString *)[description substringWithRange:NSMakeRange([description length]-maxSize-1, maxSize)];
    }
    
    return description;
}

- (NSString *)applicationLogForCrashManager:(BITCrashManager *)crashManager {
    NSString *description = [self getLogFilesContentWithMaxSize:5000]; // 5000 bytes should be enough!
    if ([description length] == 0) {
        return nil;
    } else {
        return description;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
//    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    _fileLogger = [[DDFileLogger alloc] init];
    _fileLogger.maximumFileSize = (1024 * 64); // 64 KByte
    _fileLogger.logFileManager.maximumNumberOfLogFiles = 1;
    [_fileLogger rollLogFileWithCompletionBlock:nil];
    [DDLog addLogger:_fileLogger];

    
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"f5daade2af2e413282f464201b57504d"];
    [[BITHockeyManager sharedHockeyManager].crashManager setCrashManagerStatus:BITCrashManagerStatusAutoSend];
    [[BITHockeyManager sharedHockeyManager] setUserName: [NSString stringWithFormat:@"%@-%@", @"foo", @"bar"]];
    [[BITHockeyManager sharedHockeyManager] setDelegate: self];
    [[BITHockeyManager sharedHockeyManager] startManager];

    
//    if (![[BITHockeyManager sharedHockeyManager] appEnvironment] == BIT) {
//        PSDDFormatter *psLogger = [[PSDDFormatter alloc] init];
//        [[DDTTYLogger sharedInstance] setLogFormatter:psLogger];
    
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        [DDLog addLogger:[DDASLLogger sharedInstance]];
//    }

    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
