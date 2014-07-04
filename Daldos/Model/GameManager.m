//
//  GameManager.m
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 23.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "GameManager.h"


@implementation GameManager


-(id) init{
    if (self = [super init]) {
        self.neutrals = [[NSMutableArray alloc] init];
        self.dice = [[Dice alloc] init];
        self.playerTurn =  arc4random()%2;
    }
    return self;
}


-(void) nextTurn{
    [self.dice setRolled:NO];
    self.playerTurn = !self.playerTurn;
}

-(Player *) activePlayer{
    if (![self playerTurn]){
        return [self playerOne];
    }else return [self playerTwo];
}


-(Coords *) tempVikingCoords:(Coords *)vikingCoords forDiceValue:(int)diceValue{
    int moveCount = 0;
    BOOL turnFlag;
    Coords *tempVikingCoords = [[Coords alloc] initWithX:vikingCoords.x andY:vikingCoords.y];
    while (moveCount < diceValue){
        turnFlag = YES;
        // green player
        if ([self playerTurn]){
            if ((tempVikingCoords.y == 0) && (tempVikingCoords.x == 0) && turnFlag) {
                tempVikingCoords.y ++;
                turnFlag = NO;
            }else if (tempVikingCoords.y == 0) tempVikingCoords.x --;
            
            //дошли до конца средней линии
            if ((tempVikingCoords.y == 1) && (tempVikingCoords.x > 15)&& turnFlag){
                tempVikingCoords.y--; //переход на 0 линию
                tempVikingCoords.x = 15;
                turnFlag = NO;
            }else if((tempVikingCoords.y == 1) && turnFlag) tempVikingCoords.x++;
            
            if (tempVikingCoords.y == 2){
                tempVikingCoords.y --;
            }
        }else{
            //red player
            
            if ((tempVikingCoords.y == 2) && (tempVikingCoords.x == 0) && turnFlag) {
                tempVikingCoords.y --;
                turnFlag = NO;
            }else if (tempVikingCoords.y == 2) tempVikingCoords.x --;
            
            if ((tempVikingCoords.y == 1) && (tempVikingCoords.x > 15)&& turnFlag){
                tempVikingCoords.y ++;
                tempVikingCoords.x = 15;
                turnFlag = NO;
            }else if((tempVikingCoords.y == 1)&& turnFlag){
                tempVikingCoords.x ++;
            }
            
            if (tempVikingCoords.y == 0){
                tempVikingCoords.y ++;
            }
        
        }
        if ([self.activePlayer existVikingOnCoords:tempVikingCoords]){
            tempVikingCoords.x = -1;
            tempVikingCoords.y = -1;
            return tempVikingCoords;
        }
        turnFlag = YES;
        moveCount++;
    }
    NSLog(@"Temp viking coord:   x:%d y:%d", tempVikingCoords.x, tempVikingCoords.y);
    NSLog(@"Dice: %d" , diceValue);
    return tempVikingCoords;
}


-(void) gameBoardVar:(Viking *)viking{
    
    if ( [self.dice firstDice] != 0){
        NeutralViking *neutral = [[NeutralViking alloc] init];
        [neutral setUsedDice:[self.dice firstDice]];
        [neutral setCoords:[self tempVikingCoords:viking.coords forDiceValue:[self.dice firstDice]]];
        if ([neutral.coords x] > -1) {
            [self.neutrals addObject:neutral];
        }
        
    }
    
    if ([self.dice secondDice] != 0){
        NeutralViking *neutral = [[NeutralViking alloc] init];
        [neutral setUsedDice:[self.dice secondDice]];
        [neutral setCoords:[self tempVikingCoords:viking.coords forDiceValue:[self.dice secondDice]]];
        if ([neutral.coords x] > -1) {
            [self.neutrals addObject:neutral];
        }
    }
}

-(void) killEnemy:(NeutralViking *)neutral{
    Player *enemyPlayer = [self playerTurn]? self.playerOne: self.playerTwo;
    for (Viking *viking in [enemyPlayer gamePieces]) {
        if ([viking.coords isEqual:neutral.coords]){
            [viking removeFromParent];
            [enemyPlayer.gamePieces removeObject:viking];
            break;
        }
    }
}

#pragma -
#pragma mark Checkers

-(BOOL) canMove:(Coords *)fromCoords to:(int)moveCount{
    return YES;
}

-(BOOL) isCurrentPlayerContainViking:(Viking *)viking{
    for (Viking *tempViking in [self activePlayer].gamePieces) {
        if ([tempViking isEqual:viking]) {
            return YES;
        }
    }
    return NO;
}

-(BOOL) canActivateViking:(Viking *)viking{
    if ([self isCurrentPlayerContainViking:viking] && ![viking isActive] && [self.dice diceContainDal]){
        return YES;
    }
    return NO;
}


-(BOOL) hasMove:(Player *) player{
    if (([self.dice firstDice] == 1) || ([self.dice secondDice] == 1)){
        return YES;
    }else
        for (Viking *viking in player.gamePieces) {
            if (viking.isActive)
            {
                return YES;
            }
        }
    return NO;
}

-(int) anybodyWin{
    if ([self.playerOne.gamePieces count] < 2) {
        return 1;
    }
    if ([self.playerTwo.gamePieces count] < 2) {
        return 0;
    }
    return -1;
}

@end
