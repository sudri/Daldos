//
//  Viking.m
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 17.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "Viking.h"
#import <objc/message.h>

@implementation Viking{
    NSTimer *timer;
}


-(id) initWithColor:(UIColor *)color{
    if ([color isEqual: [UIColor greenColor]]) {
        self = [super initWithImageNamed:@"greenVikingNoActive.png"];
    }else{
        self = [super initWithImageNamed:@"redVikingNoActive.png"];
    }
    
    //[self setIsActive:NO];
    self.color = color;
    [self setUserInteractionEnabled:YES];
    return self;
}


- (void) setIsActive:(BOOL)isActive{
    //if (isActive) {
    _isActive = isActive;
    if ([self.color isEqual: [UIColor greenColor]]) {
        [self setTexture:[SKTexture textureWithImageNamed:@"greenViking.png"]];
    }else{
        [self setTexture:[SKTexture textureWithImageNamed:@"redViking.png"]];
    }
    //}
}

-(void) setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.5];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.5];
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[fadeOut,fadeIn]]]];
    }else{
        [self setAlpha:1.0f];
        [self removeAllActions];
    }
}


#pragma -
#pragma mark Touch Handling

/**
 * This method only occurs, if the touch was inside this node. Furthermore if
 * the Button is enabled, the texture should change to "selectedTexture".
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(touches.count == 1)
    {
        if(([[touches anyObject] tapCount] == 2) && timer)
        {
            [timer invalidate];
            timer = nil;
            [self.delegate doubleTapOnViking:self];
            
        }else{
            timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(singleTap) userInfo:nil repeats:NO];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            
        }
    }
}

-(void) singleTap{
    [self.delegate singleTapOnViking:self];
}



@end
