//
//  Player.m
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 17.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "Player.h"


@implementation Player

-(id) initWithCapacity:(int)capacity :(UIColor *) playerColor{
    if (self = [super init]) {
        self.gamePieces = [[NSMutableArray alloc] init];
        for (int i = 0; i < capacity; i++) {
            Viking *viking = [[Viking alloc] initWithColor:playerColor];
            [[self gamePieces] addObject:viking];
        }
    }
    return self;
}

-(BOOL) existVikingOnCoords:(Coords *)coords{
    for (Viking *viking in [self gamePieces]) {
        if ([viking.coords isEqual:coords]) {
            return YES;
        }
    }
    return NO;
}
@end
