//
//  GameManager.h
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 23.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Viking.h"
#import "Dice.h"
#import "NeutralViking.h"

@interface GameManager : NSObject



//@property (nonatomic) NSMutableArray *gameBoard;
@property (nonatomic) Dice *dice;
@property (nonatomic) Player *playerOne;
@property (nonatomic) Player *playerTwo;
@property (nonatomic) NSMutableArray *neutrals;

@property (nonatomic) BOOL rolled;
@property (nonatomic) BOOL playerTurn;



-(void) nextTurn;
-(void) killEnemy: (NeutralViking *) neutral;
-(void) gameBoardVar : (Viking *) viking;

-(Player *) activePlayer;
-(Coords *) tempVikingCoords:(Coords *) vikingCoords forDiceValue: (int) value;

-(BOOL) isCurrentPlayerContainViking: (Viking *) viking;
-(BOOL) canActivateViking:(Viking *) viking;
-(BOOL) hasMove: (Player *) player;
-(BOOL) canMove: (Coords *) fromCoords to:(int) moveCount;
-(int) anybodyWin;

@end
