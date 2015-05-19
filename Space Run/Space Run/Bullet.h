//
//  Bullet.h
//  Space Run
//
//  Created by Owner Owner on 02.02.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "Unit.h"

@interface Bullet : Unit
@property (assign) CGPoint direction;
@property (assign) char damage;
-(Bullet*) initWithExample:(Unit*) example Position:(CGPoint) pos Team:(char) iTeam Direction:(CGPoint) dir;
-(Bullet*) initWithPosition:(CGPoint) pos Direction:(CGPoint) dir Team:(char) cTeam;

@end
