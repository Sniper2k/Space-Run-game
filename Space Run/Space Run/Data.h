//
//  Data.h
//  Space Run
//
//  Created by Owner Owner on 04.02.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class Unit;
@interface Data : NSObject
@property (retain) NSDictionary* examples;
@property (retain) NSArray* ways;
-(void) loadExamplesFromDB:(NSArray*) keys;
-(Unit*) unitWithPrimaryKey:(NSInteger) pk Database:(sqlite3*) db;
@end
