//
//  Unit.m
//  Space Run
//
//  Created by Owner Owner on 31.01.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "Unit.h"

@implementation Unit
@synthesize speed=speed,radius=radius, health=health,sprite=sprite, z=z, team=team, key=key, bullet_id;

-(Unit*) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(Unit*) initWithExample:(Unit *)example Position:(CGPoint)pos Team:(char)iTeam
{
    self = [super init];
    if (self)
    {
        speed = example.speed;
        radius = example.radius;
        health = example.health;
        z = example.z;
        team = iTeam;
        key = example.key;
        bullet_id = example.bullet_id;
        
        self.sprite = [[CCSprite alloc] initWithFile:[NSString stringWithFormat:@"%i.png",key]];
        sprite.position = pos;
    }
    return self;
}

-(void) dealloc
{
    [sprite stopAllActions];
    [sprite release];
    [super dealloc];
}

-(NSArray*) turn:(float)dt
{
    return nil;
}

-(BOOL) isDead
{
    if (health<=0)
    {
        return YES;
    }
    
    return NO;
}
@end
