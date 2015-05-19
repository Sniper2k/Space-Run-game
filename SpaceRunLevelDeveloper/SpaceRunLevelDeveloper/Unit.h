//
//  Unit.h
//  Space Run
//
//  Created by Owner Owner on 31.01.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ACTION_NONE 0
#define ACTION_MOVE 1

@interface Unit : NSObject
{
    float speed;
    int health;
    float radius;
    char z;
    char team;
    int bullet_id;
}
@property (assign) float speed;
@property (assign) int health;
@property (assign) float radius;
@property (assign) char z;
@property (assign) char team;
@property (assign) int key;
@property (assign) int bullet_id;
-(Unit*) initWithExample:(Unit*) example Position:(CGPoint) pos Team:(char) iTeam;
-(NSArray*) turn:(float) dt;
-(BOOL) isDead;

@end
