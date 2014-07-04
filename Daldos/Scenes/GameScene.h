//
//  GameScene.h
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 17.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameManager.h"
#import "EPButton.h"
#import "SKButton.h"
#import "Viking.h"

@interface GameScene : SKScene <Viking,NeutralViking>

@property (nonatomic) SKShapeNode * board;
@property (nonatomic) GameManager *gameManager;
@property (nonatomic) CGRect boardRect;
@property (nonatomic) EPButton *rollP1;
@property (nonatomic) EPButton *rollP2;
@property (nonatomic) EPButton *skipP1;
@property (nonatomic) EPButton *skipP2;
@property (nonatomic) SKButton *tempButton;
@property (nonatomic) SKLabelNode *dice1;
@property (nonatomic) SKLabelNode *dice2;
@property (nonatomic) Player *playerOne;
@property (nonatomic) Player *playerTwo;
@property (nonatomic) BOOL showBoardOnInit;
@property (nonatomic) Viking *selectedViking;


-(SKShapeNode *) getBoard:(CGRect) rect lineWidth:(CGFloat) lineWidth;
-(void) initButtons;
-(void) initDices;
-(void) initPlayers;

-(void) showBoard;
-(void) showDices;
-(void) activeSkip;
-(void) rollPressed;
-(void) nextTurn;
-(void) hideDices;

-(void) singleTapOnViking:(id) viking;
-(void) doubleTapOnViking:(id) viking;

@end
