//
//  Player.h
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 17.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Viking.h"

@interface Player : NSObject


@property (nonatomic) NSMutableArray *gamePieces;
@property (nonatomic) int xOffset;
@property (nonatomic) int yOffset;


-(id) initWithCapacity:(int) capacity : (UIColor*) playerColor;
-(BOOL) existVikingOnCoords:(Coords *) coords;

@end
