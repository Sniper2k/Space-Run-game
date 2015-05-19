//
//  Bullet.m
//  Space Run
//
//  Created by Owner Owner on 02.02.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "Bullet.h"
#import "Global.h"

@implementation Bullet
@synthesize direction, damage;

-(Bullet*) initWithPosition:(CGPoint)pos Direction:(CGPoint)dir Team:(char)cTeam
{
    self = [super init];
    if (self)
    {
        // temporary
        self.sprite = [[CCSprite alloc] initWithFile:@"bullet1.png"];
        speed = 100;
        sprite.position = pos;
        radius = ccpDistance(ccp(0,0), ccp(sprite.contentSize.width/2,sprite.contentSize.height/2));
        health=1;
        // temporary end
        
        dir = ccpMult(dir, 1+ccpDistance(ccp(0,0), ccp(sprite.contentSize.width, sprite.contentSize.height))/ccpDistance(dir, pos));
        
        self.direction = dir;
        [sprite runAction:[CCMoveTo actionWithDuration:ccpDistance(dir, pos)/speed position:dir]];
        
        damage = health;
        health =1;
        
        team = cTeam;
        
    }
    return self;
}

-(Bullet*) initWithExample:(Unit *)example Position:(CGPoint)pos Team:(char)iTeam Direction:(CGPoint)dir
{
    self = [super initWithExample:example Position:pos Team:iTeam];
    if(self)
    {
        dir = ccpAdd(pos, ccpMult(ccpSub(dir, pos), 1+ccpDistance(ccp(0,0), ccp(sprite.contentSize.width, sprite.contentSize.height))/ccpDistance(dir, pos)));
        
        self.direction = dir;
        [sprite runAction:[CCMoveTo actionWithDuration:ccpDistance(dir, pos)/speed position:dir]];
        
        damage = health;
        health =1;
    }
    return self;
}

-(NSArray*) turn:(float)dt
{
    if (sprite.position.x<= -sprite.contentSize.width/2 ||
        sprite.position.x>= sprite.contentSize.width/2 + sizeW ||
        sprite.position.y>= sprite.contentSize.height/2 + sizeH ||
        sprite.position.y<= -sprite.contentSize.height/2)
        health=0;
    return nil;
}

-(void) dealloc
{
    [super dealloc];
}
@end
