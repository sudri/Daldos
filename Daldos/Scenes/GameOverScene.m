//
//  GameOverScene.m
//  Daldos
//
//  Created by Эдуард Пятницын on 04.07.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size winner:(int)player
{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        SKLabelNode *winner = [[SKLabelNode alloc] init];
        NSString *playerName = player?NSLocalizedString(@"Green player win!",nil):NSLocalizedString(@"Red player win!",nil);
        [winner setText:playerName];
        [winner setPosition:CGPointMake(self.size.width / 2 , self.size.height / 2)];
        SKAction *rotate = [SKAction rotateToAngle:360 duration:240];
        [winner runAction:[SKAction repeatActionForever:rotate]];
    
        [self addChild:winner];
        
        NSString *burstPath =[[NSBundle mainBundle] pathForResource:@"Sparks" ofType:@"sks"];
        SKEmitterNode *burstNode = [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
        burstNode.position = CGPointMake(self.size.width / 2 , self.size.height / 2);
        [burstNode runAction:[SKAction repeatActionForever:[SKAction moveTo:(CGPointMake(arc4random() % (int)self.size.height , arc4random() % (int)self.size.width)) duration:10]]];
        
        [self addChild:burstNode];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
    GameScene *newGameScene = [[GameScene alloc] initWithSize: [self size]];
    newGameScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene: newGameScene transition: reveal];
}

@end
