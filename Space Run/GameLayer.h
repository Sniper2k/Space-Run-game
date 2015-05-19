//
//  GameLayer.h
//  Space Run
//
//  Created by Owner Owner on 30.01.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define MENUBUTTONCONSTY 1.0f/5
#define MENUBUTTONCONSTX 5.0f/6

@class Player;
@class Unit;
@interface GameLayer : CCLayer
//@property (assign) float playerPosNew;
@property (assign) BOOL onTouchMove;
@property (retain) Player* player;
@property (retain) NSMutableArray* units;
@property (retain) NSMutableArray* bullets;
@property (assign) BOOL paused;
+(CCScene *) scene;
-(void) timerFunc:(ccTime) dt;
-(void) menuButon;
-(BOOL) checkConflictBeetween:(Unit*) unit Bullet:(Unit*) bullet;
-(void) loadLvl:(int) lvl;

@end
