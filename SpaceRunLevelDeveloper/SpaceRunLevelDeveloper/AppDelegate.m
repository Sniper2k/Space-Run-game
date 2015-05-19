//
//  AppDelegate.m
//  SpaceRunLevelDeveloper
//
//  Created by Owner Owner on 06.02.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    [_shipArrayController addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1", @"Ships", nil]];
}

@end
