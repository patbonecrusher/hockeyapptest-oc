//
//  AppDelegate.h
//  hockeyapptest-oc
//
//  Created by Patrick Laplante on 8/19/18.
//  Copyright © 2018 Patrick Laplante. All rights reserved.
//

#import <UIKit/UIKit.h>
@import HockeySDK;
@import CocoaLumberjack;

@interface AppDelegate : UIResponder <UIApplicationDelegate, BITHockeyManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) DDFileLogger *fileLogger;


@end

