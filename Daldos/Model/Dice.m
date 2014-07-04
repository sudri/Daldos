//
//  Dice.m
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 26.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "Dice.h"

@implementation Dice

-(id) init{
    if (self = [super init]){
        [self setRolled:NO];
    }
    return self;
}

- (int) count{
    int count = 0;
    if ([self firstDice] != 0) count++;
    if ([self secondDice] != 0) count++;
    return count;
}

-(BOOL) removeDiceWithInt:(int)num{
    if ([self firstDice] == num){
        [self setFirstDice:0];
        return YES;
    }
    if ([self secondDice] == num){
        [self setSecondDice:0];
        return YES;
    }
    return NO;
}

-(BOOL) isDicesEmpty{
    if (([self firstDice] == 0)&&([self secondDice] == 0)) {
        return YES;
    }
    return NO;
}

- (BOOL) diceContainDal{
    if (([self firstDice] == 1) || ([self secondDice] == 1)){
        return YES;
    }
    return NO;
}

- (void) rollDices{
    if (!self.rolled){
        [self setFirstDice: 1 + arc4random()%4];
        [self setSecondDice: 1 + arc4random()%4];
//        [self setFirstDice:1];
//        [self setSecondDice:1];
        [self setRolled:YES];
    }
}

@end
