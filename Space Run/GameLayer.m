//
//  GameLayer.m
//  Space Run
//
//  Created by Owner Owner on 30.01.14.
//  Copyright (c) 2014 Sniper. All rights reserved.
//

#import "GameLayer.h"
#import "MainMenuLayer.h"
#import "Player.h"
#import "Global.h"
#import "Bullet.h"

@implementation GameLayer
@synthesize player, units,bullets, paused;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
    [layer loadLvl:0];
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
		paused = YES;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        sizeW = size.width;
        
        
        CCSprite* back = [CCSprite spriteWithFile:@"bg1.jpg"];
        back.position = ccp(size.width/2, size.height/2);
        [self addChild:back z:0];
        
        CCSprite* panel = [CCSprite spriteWithFile:@"panel.jpg"];
        panel.position = ccp(size.width/2, size.height - panel.contentSize.height/2);
        [self addChild:panel z:5];
        
        sizeH = size.height - panel.contentSize.height;
        
        
        self.units = [[NSMutableArray alloc] init];
        self.bullets = [[NSMutableArray alloc] init];
        
        CCMenuItemImage* button = [CCMenuItemImage itemWithNormalImage:@"menuButton.png" selectedImage:@"menuButton.png" target:self selector:@selector(menuButon)];
        button.position = ccp(size.width*MENUBUTTONCONSTX, panel.position.y - panel.contentSize.height*MENUBUTTONCONSTY);
        
        CCMenu* menu = [CCMenu menuWithItems:button, nil];
        menu.position = ccp(0,0);
        [self addChild:menu z:5];
        
        [self schedule:@selector(timerFunc:)];
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	}
	return self;
}

-(void) loadLvl:(int)lvl
{
    g_data = [[Data alloc] init];
    
    self.player = [[Player alloc] initWithExample:[g_data.examples objectForKey:[NSNumber numberWithInt:1]]
                                         Position:ccp(sizeW/2,0) Team:1];
    [self addChild:player.sprite z:player.z];
    [units addObject:player];
    
    
    Unit* unit = [[Unit alloc] initWithExample:[g_data.examples objectForKey:[NSNumber numberWithInt:2]] Position:ccp(sizeW,sizeH) Team:2];
    
    unit.sprite.position = ccp(sizeW - unit.sprite.contentSize.width/2,sizeH - unit.sprite.contentSize.height/2);
    [self addChild:unit.sprite z:unit.z];
    [units addObject:unit];
    [unit release];
    
    paused = NO;
}


-(void) timerFunc:(ccTime)dt
{
    if (paused)
        return;
    
    for (Unit* unit in units)
    {
        NSArray* new_units =[unit turn:dt];
        
        if (new_units!=nil)
        {
            
            
            if ([new_units[0] count]!=0)
            {
                [bullets addObjectsFromArray:new_units[0]];
                for (Unit* newUnit in new_units[0])
                {
                    [self addChild:newUnit.sprite z:newUnit.z];
                }
            }
        
            if ([new_units[1] count]!=0)
            {
                [units addObjectsFromArray:new_units[1]];
                for (Unit* newUnit in new_units[1])
                {
                    [self addChild:newUnit.sprite z:newUnit.z];
                }
            }
        }
    }
    
    
    
    for (Unit* bullet in bullets)
    {
        [bullet turn:dt];
    }
    
    for (Unit* unit in units)
    {
        for (Bullet* bullet in bullets)
        {
            if ([self checkConflictBeetween:unit Bullet:bullet])
            {
                unit.health-=bullet.damage;
                bullet.health=0;
            }
        }
    }
    
    
    if ([units count]>1)
    {
        for (size_t i=1;i<[units count];i++)
        {
            if ([self checkConflictBeetween:player Bullet:units[i]])
            {
                player.health--;
                [units[i] setHealth:0];
            }
        }
    }
    
    for (size_t i = [units count]-1;i!=-1;i--)
    {
        Unit* unit = units[i];
        if ([unit isDead])
        {
            [self removeChild:unit.sprite];
            [units removeObjectAtIndex:i];
        }
        unit = nil;
    }
    
    for (size_t i = [bullets count]-1;i!=-1;i--)
    {
        Unit* unit = bullets[i];
        if ([unit isDead])
        {
            [self removeChild:unit.sprite];
            [bullets removeObjectAtIndex:i];
        }
        unit = nil;
    }
    
    if ([player isDead])
    {
        [self menuButon];
    }
}

-(BOOL) checkConflictBeetween:(Unit *)unit Bullet:(Unit *)bullet
{
    if (unit.team == bullet.team)
        return NO;
    
    if (unit.health<=0 || bullet.health<=0)
        return NO;
    
    if (ccpDistance(unit.sprite.position, bullet.sprite.position)<unit.radius+bullet.radius)
        return YES;
    
    return NO;
}

-(void) menuButon
{
    paused = YES;
    
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
    
    [g_data release];
    g_data = nil;
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!paused)
    {
        CGPoint touchPosition = [self convertTouchToNodeSpace: touch];
        [player setNewPos:touchPosition.x];
    }
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!paused)
    {
        CGPoint touchPosition = [self convertTouchToNodeSpace: touch];
        [player setNewPos:touchPosition.x];
    }
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!paused)
    {
        CGPoint touchPosition = [self convertTouchToNodeSpace: touch];
        [player setNewPos:touchPosition.x];
    }
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!paused)
    {
        CGPoint touchPosition = [self convertTouchToNodeSpace: touch];
        [player setNewPos:touchPosition.x];
    }
}

- (void) dealloc
{
   	[units release];
    [bullets release];
    [player release];
	[super dealloc];
}
@end
