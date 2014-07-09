//
//  NeutralViking.h
//  Daldos
//
//  Created by Эдуард Пятницын on 27.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Viking.h"
#import "Coords.h"

@protocol NeutralViking <NSObject>

- (void) singleTapOnNeutralViking: (id) viking;

@end

@interface NeutralViking : SKSpriteNode
@property id delegate;
@property (nonatomic) int usedDice;
@property (nonatomic) Coords* coords;
@property (nonatomic) Viking* viking;

@end
