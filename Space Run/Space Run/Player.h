//
//  Player.h
//  Space Run
//
//  Created by Owner Owner on 31.01.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "Unit.h"

#define CALLDOWN 0.5f

@interface Player : Unit
@property (assign) float moveToPos;
@property (assign) float calldown;
-(Player*) initWithExample:(Unit*) example Position:(CGPoint) pos Team:(char) iTeam;
-(BOOL) isDead;
-(void) setNewPos:(float) newPos;
@end
