//
//  NeutralViking.m
//  Daldos
//
//  Created by Эдуард Пятницын on 27.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "NeutralViking.h"

@implementation NeutralViking

-(id) init {
    self = [super initWithImageNamed:@"whiteViking.png"];
    [self setSize:CGSizeMake(50, 50)];
    [self setUserInteractionEnabled:YES];
    [self setName:@"neutral"];
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.5];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.5];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[fadeOut,fadeIn]]]];
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate singleTapOnNeutralViking:self];
}

@end
