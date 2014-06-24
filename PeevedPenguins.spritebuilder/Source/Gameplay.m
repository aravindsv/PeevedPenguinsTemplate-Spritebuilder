//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Aravind Vadali on 6/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay
{
    CCNode *_catapultArm;
    CCPhysicsNode *_physicsNode;
    CCNode *_levelNode;
    CCNode *_contentNode;
}

-(void)didLoadFromCCB
{
    CCLOG(@"Loaded from CCB");
    self.userInteractionEnabled = YES;
    if (self.userInteractionEnabled)
        CCLOG(@"User Interaction is enabled");
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"screen touched");
    [self launchPenguin];
}

-(void)launchPenguin
{
    CCNode *penguin = [CCBReader load:@"Penguin"];
    float x = _catapultArm.position.x;
    float y = _catapultArm.position.y;
    CCLOG(@"X Position is %f. Y position is %f", x, y);
    penguin.position = ccpAdd(_catapultArm.position, ccp(15, 50));
    
    [_physicsNode addChild:penguin];
    
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
    self.position = ccp(0, 0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
}

-(void)retry
{
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"Gameplay"]];
}

@end
