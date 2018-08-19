//
//  ViewController.m
//  hockeyapptest-oc
//
//  Created by Patrick Laplante on 8/19/18.
//  Copyright © 2018 Patrick Laplante. All rights reserved.
//

#import "ViewController.h"
@import CocoaLumberjack;

@interface ViewController ()

@end

@implementation ViewController
static const DDLogLevel ddLogLevel = DDLogLevelDebug;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTap:(id)sender {
    @[][666];
}

- (IBAction)onAddLog:(id)sender {
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
}
@end
