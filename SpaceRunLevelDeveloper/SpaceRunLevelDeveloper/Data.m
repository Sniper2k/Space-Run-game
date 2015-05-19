//
//  Data.m
//  Space Run
//
//  Created by Owner Owner on 04.02.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "Data.h"
#import "Unit.h"

static sqlite3_stmt *init_statement = nil;

@implementation Data
@synthesize examples,ways;

-(Data*) init
{
    self = [super init];
    if (self)
    {
        //self.examples = [[NSDictionary alloc] init];
        
        /*Unit* player = [[Unit alloc] init];
        player.health = 1;
        player.speed = 70;
        player.z = 4;
        player.key = 1;
        player.bullet_id = 3;
        
        Unit* enemy = [[Unit alloc] init];
        enemy.health = 1;
        enemy.speed = 50;
        enemy.z = 2;
        enemy.key = 2;
        enemy.radius = 12.0f;
        
        Unit* bullet = [[Unit alloc] init];
        bullet.speed = 100;
        bullet.key = 3;
        bullet.health = 1;
        bullet.z = 3;
        bullet.radius = 4;
        
        NSArray* objects = [NSArray arrayWithObjects:player,enemy,bullet, nil];*/
        
        NSArray* keys = [NSArray arrayWithObjects:
                       [NSNumber numberWithInt:1],
                       [NSNumber numberWithInt:2],
                       [NSNumber numberWithInt:3],
                       nil];

        //self.examples = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
        
        [self loadExamplesFromDB:keys];
        
        self.ways = [[NSArray alloc] init];
        
        /*[player release];
        [enemy release];
        [bullet release];*/
        
    }
    return self;
}

-(void) loadExamplesFromDB:(NSArray *)keys
{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    uint index;
    uint count;
    NSString* path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SpaceRun.sqlite"];
    sqlite3* database;
    
    if (sqlite3_open([path UTF8String],&database) == SQLITE_OK)
    {
        const char* sql_s = "SELECT pk FROM units";
        sqlite3_stmt* statement;
        
        if (sqlite3_prepare_v2(database, sql_s, -1, &statement, NULL) == SQLITE_OK)
        {
            index =0;
            count = [keys count];
            while (sqlite3_step(statement) == SQLITE_ROW && index<count)
            {
                int pk = sqlite3_column_int(statement, 0);
                
                if (pk == [[keys objectAtIndex:index] intValue])
                {
                    Unit* unit = [self unitWithPrimaryKey:pk Database: database];
                    [dict setObject:unit forKey:[NSNumber numberWithInt:pk]];
                    unit = nil;
                    index++;
                }
            }
            
            self.examples = [[NSDictionary alloc] initWithDictionary:dict];
        }
        
        sqlite3_finalize(statement);
    }
    
    dict = nil;
    sqlite3_close(database);
}

-(Unit*) unitWithPrimaryKey:(NSInteger)pk Database:(sqlite3 *)db
{
    Unit* unit = [[Unit alloc] init];
    
    unit.key = pk;
    
    if (init_statement == nil)
    {
        const char* sql = "SELECT health,speed,radius,bullet_id,z FROM units WHERE pk=?";
        if (sqlite3_prepare_v2(db, sql, -1, &init_statement, NULL) != SQLITE_OK)
        {
            NSAssert(0,@"Error: failed to prepare statment with message '%s'.", sqlite3_errmsg(db));
        }
    }
    
    sqlite3_bind_int (init_statement,1,pk);
    if (sqlite3_step(init_statement) == SQLITE_ROW)
    {
        unit.health = sqlite3_column_int(init_statement,0);
        unit.speed = sqlite3_column_double(init_statement,1);
        unit.radius = sqlite3_column_double(init_statement,2);
        unit.bullet_id = sqlite3_column_int(init_statement,3);
        unit.z = sqlite3_column_int(init_statement,4);
    }
    
    sqlite3_reset(init_statement);
    
    return unit;
}

-(void) dealloc
{
    ways = nil;
    examples = nil;
}
@end
