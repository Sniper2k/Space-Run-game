//
//  AppDelegate.h
//  SpaceRunLevelDeveloper
//
//  Created by Owner Owner on 06.02.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView* shipTable;
@property (assign) IBOutlet NSArrayController* shipArrayController;
-(IBAction) createObject;
@end
