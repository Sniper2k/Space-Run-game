//
//  Player.m
//  Space Run
//
//  Created by Owner Owner on 31.01.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "Player.h"
#import "Global.h"
#import "Bullet.h"

@implementation Player
@synthesize moveToPos, calldown;

-(Player*) init
{
    self = [super init];
    if (self)
    {
        self.sprite =[[CCSprite alloc] initWithFile:@"0.png"];
        sprite.position = ccp(sizeW/2,sprite.contentSize.height/2);
        health = 1;
        speed = 70;
        calldown=0;
        z=4;
        team = 1;
        bullet_id = 2;
        
        moveToPos = sprite.position.x;
        
    }
    return self;
}

-(Player*) initWithExample:(Unit *)example Position:(CGPoint)pos Team:(char)iTeam
{
    self = [super initWithExample:example Position:pos Team:iTeam];
    if (self)
    {
        sprite.position = ccp(pos.x,sprite.contentSize.height/2);
        calldown=0;
        moveToPos = sprite.position.x;
    }
    return self;
}

-(void) dealloc
{
    
    [super dealloc];
}


-(BOOL) isDead
{
    if (health>0)
        return NO;
    
    return  YES;
}

-(NSArray*) turn:(float)dt
{
    NSArray* ret_array=nil;
    calldown+=dt;
    if (calldown>=CALLDOWN)
    {
        Bullet* bullet = [[Bullet alloc]
                          initWithExample:[g_data.examples objectForKey:[NSNumber numberWithInt:bullet_id]]
                          Position:sprite.position
                          Team:team
                          Direction:ccp(sprite.position.x,sizeH)];
        //[[Bullet alloc] initWithPosition:sprite.position Direction:ccp(sprite.position.x,sizeH) Team:team];
        
        ret_array =[NSArray arrayWithObjects:
                    [NSArray arrayWithObject:bullet],
                    [NSArray array], nil];
        calldown-=CALLDOWN;
        
        [bullet release];

    }
    
    float newPos = sign(moveToPos - sprite.position.x)*speed*dt + sprite.position.x;
    if (sign(moveToPos-newPos)!=sign(moveToPos - sprite.position.x))
        newPos = moveToPos;
    
    sprite.position = ccp(newPos,sprite.position.y);
    
    
    return ret_array;
}

-(void) setNewPos:(float)newPos
{
    if (newPos>= sizeW-sprite.contentSize.width/2)
        newPos = sizeW-sprite.contentSize.width/2;
    
    if (newPos<= sprite.contentSize.width/2)
        newPos = sprite.contentSize.width/2;
    
    moveToPos = newPos;
}
@end
