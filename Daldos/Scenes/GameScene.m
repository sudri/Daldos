//
//  GameScene.m
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 16.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>

#import "GameScene.h"
#import "Viking.h"
#import "NeutralViking.h"
#import "GameOverScene.h"


@implementation GameScene

#pragma
#pragma mark -- Init scene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self setShowBoardOnInit: YES];
        self.backgroundColor = [UIColor colorWithRed:0.944 green:0.856 blue:0.534 alpha:1.000];
        int boardWidth = 5 * size.width / 7;
        int boardHeight = (3 * boardWidth) / 16;
        self.boardRect = CGRectMake(size.width / 2  - boardWidth / 2  - boardWidth / 16, size.height / 2  - boardHeight / 2, boardWidth, boardHeight);
        self.board = [self getBoard:self.boardRect lineWidth:0.01f];
        [self addChild:self.board];
        self.gameManager = [[GameManager alloc] init];
        [self initPlayers];
        [self showBoard];
        [self initButtons];
        [self initDices];
        [self setShowBoardOnInit:NO];
    }
    return self;
}

-(SKShapeNode *) getBoard:(CGRect) rect lineWidth:(CGFloat) lineWidth{
    SKShapeNode *board = [[SKShapeNode alloc] init];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    for( float i = rect.origin.x ; i <  rect.size.width + rect.origin.x; i += 2 * (rect.size.width / 16)){
        
        CGPathAddRect(path, NULL, CGRectMake(i + rect.size.width / 16, rect.origin.y, rect.size.width / 16, rect.size.height / 3));
        CGPathAddRect(path, NULL, CGRectMake(i , rect.origin.y + rect.size.height / 3, rect.size.width / 16, rect.size.height / 3));
        CGPathAddRect(path, NULL, CGRectMake(i + rect.size.width / 16,  rect.origin.y + 2 * rect.size.height/3, rect.size.width / 16, rect.size.height / 3));
    }
    
    CGPathAddRect(path, NULL, CGRectMake(rect.size.width + rect.origin.x , rect.origin.y + rect.size.height / 3, rect.size.width / 17, rect.size.height / 3));
    
    
    // ----
    CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width , rect.origin.y + rect.size.height);
    // ----
    //      \
    
    CGPathMoveToPoint(path, NULL, rect.origin.x + rect.size.width , rect.origin.y + rect.size.height);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width + rect.size.width / 17 , rect.origin.y + 2 * rect.size.height / 3);
    // ----
    //      \
    //       |
    
    CGPathMoveToPoint(path, NULL, rect.origin.x + rect.size.width + rect.size.width / 17, rect.origin.y + 2 * rect.size.height / 3);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width + rect.size.width / 17, rect.origin.y + rect.size.height / 3);
    // ----
    //      \
    //       |
    //      /
    CGPathMoveToPoint(path, NULL, rect.origin.x + rect.size.width + rect.size.width / 17, rect.origin.y + rect.size.height / 3);
    CGPathAddLineToPoint(path, NULL, rect.origin.x + rect.size.width , rect.origin.y);
    // ----
    //      \
    //       |
    //      /
    // ----
    
    CGPathMoveToPoint(path, NULL,rect.origin.x + rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y);
    // ----
    //|     \
    //|      |
    //|     /
    // ----
    CGPathMoveToPoint(path, NULL,rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y + rect.size.height);
    
    board.path = path;
    board.lineWidth = lineWidth;
    CGPathRelease(path);
    board.fillColor = [SKColor blackColor];
    board.strokeColor = [SKColor blackColor];
    board.glowWidth = 0.05f;
    board.name = @"gameBoard";
    return board;
}

-(void) initDices{
    self.dice1 = [[SKLabelNode alloc] init];
    self.dice1.position = CGPointMake(self.size.width * 0.05f, self.size.height * 0.495f);
    self.dice1.fontSize = 20;
    self.dice1.fontColor = [UIColor blackColor];
    [self addChild:self.dice1];
    
    self.dice2 = [[SKLabelNode alloc] init];
    self.dice2.position = CGPointMake(self.size.width * 0.9f, self.size.height * 0.495f);
    self.dice2.fontSize = 20;
    self.dice2.fontColor = [UIColor blackColor];
    [self addChild:self.dice2];
    
    
}

-(void) initButtons{
    int fontSize = 30;
    self.rollP1 = [[EPButton alloc] initWithActiveColor:[SKColor blackColor] nonActiveColor:[SKColor grayColor]];
    self.rollP1.position =  CGPointMake(self.size.width / 2 , self.size.height * 0.25f);
    self.rollP1.fontSize = fontSize;
    self.rollP1.text = NSLocalizedString(@"Roll",nil);
    self.rollP1.name = @"rollP1";
    [self.rollP1 setIsActive:false];
    [self.rollP1 setTouchUpInsideTarget:self action:@selector(rollPressed)];
    [self addChild:self.rollP1];
    
    self.rollP2 = [[EPButton alloc] initWithActiveColor:[SKColor blackColor] nonActiveColor:[SKColor grayColor]];
    self.rollP2.position =  CGPointMake(self.size.width / 2 , self.size.height * 0.75f);
    self.rollP2.fontSize = fontSize;
    self.rollP2.text = NSLocalizedString(@"Roll",nil);
    self.rollP2.name = @"rollP2";
    self.rollP2.zRotation = M_PI;
    [self.rollP2 setIsActive:false];
    [self.rollP2 setTouchUpInsideTarget:self action:@selector(rollPressed)];
    [self addChild:self.rollP2];
    
    self.skipP1 = [[EPButton alloc] initWithActiveColor:[SKColor blackColor] nonActiveColor:[SKColor grayColor]];
    self.skipP1.position =  CGPointMake(self.size.width * 0.2f, self.size.height * 0.25f);
    self.skipP1.fontSize = fontSize;
    self.skipP1.text = NSLocalizedString(@"Skip",nil);
    self.skipP1.name = @"skipP1";
    [self.skipP1 setIsActive:false];
    [self.skipP1 setTouchUpInsideTarget:self action:@selector(nextTurn)];
    [self addChild:self.skipP1];
    
    self.skipP2 = [[EPButton alloc] initWithActiveColor:[SKColor blackColor] nonActiveColor:[SKColor grayColor]];
    self.skipP2.position =  CGPointMake(self.size.width * 0.8f, self.size.height * 0.75f);
    self.skipP2.fontSize = fontSize;
    self.skipP2.text = NSLocalizedString(@"Skip",nil);
    self.skipP2.name = @"skipP2";
    self.skipP2.zRotation = M_PI;
    [self.skipP2 setIsActive:false];
    [self.skipP2 setTouchUpInsideTarget:self action:@selector(nextTurn)];
    [self addChild:self.skipP2];
    
    [self nextTurn];
}

-(void) initPlayers{
    self.playerOne = [[Player alloc] initWithCapacity:16 :[UIColor redColor]];
    NSLog(@"Vikings");
    int x = 0;
    for (Viking *tempViking in self.playerOne.gamePieces) {
        [tempViking setDelegate:self];
        Coords *vc = [[Coords alloc] initWithX:x andY:0];
        tempViking.coords = vc;
        [tempViking setScale:2 * (self.boardRect.size.height/10)/tempViking.size.height];
        x++;
    }
    
    
    self.playerTwo = [[Player alloc] initWithCapacity:16 :[UIColor greenColor]];
    x = 0;
    for (Viking *tempViking in self.playerTwo.gamePieces) {
        [tempViking setDelegate:self];
        Coords *vc = [[Coords alloc] initWithX:x andY:2];
        [tempViking setCoords: vc];
        [tempViking setScale:2 * (self.boardRect.size.height/10)/tempViking.size.height];
        x++;
        
    }
    
    [self.gameManager setPlayerOne:self.playerOne];
    [self.gameManager setPlayerTwo:self.playerTwo];
}

#pragma mark - Buttons action

-(void) rollPressed{
    [self.gameManager.dice rollDices];
    [self showDices];
    if(self.gameManager.playerTurn == 0){
        if (![self.gameManager hasMove:self.playerOne]) [self activeSkip];
    }
    if(self.gameManager.playerTurn == 1){
        if (![self.gameManager hasMove:self.playerTwo]) [self activeSkip];
    }
}



-(void) nextTurn{
    if ([self.gameManager anybodyWin] == -1){
        [self.gameManager nextTurn];
        if ([self.gameManager playerTurn] == 0 ){
            [self.rollP1 setIsActive:true];
            [self.rollP2 setIsActive:false];
        }else{
            [self.rollP1 setIsActive:false];
            [self.rollP2 setIsActive:true];
        }
        [self.skipP1 setIsActive:false];
        [self.skipP2 setIsActive:false];
        [self hideDices];
    }else{
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        GameOverScene *gameOverScene = [[GameOverScene alloc] initWithSize: [self size] winner:[self.gameManager anybodyWin]];
        [self.scene.view presentScene: gameOverScene transition: reveal];
    }
}


#pragma -
#pragma mark Viking Protocol
-(void) singleTapOnViking:(id) viking{
    NSLog(@"1Tap");
    
    Viking *tappedViking = viking;
    
    for (NeutralViking *neutral in [self.gameManager neutrals]) {
        [neutral removeFromParent];
    }
    self.gameManager.neutrals = [[NSMutableArray alloc] init];
    [self showBoard];
    //[self setSelectedViking:viking];
    if ([self.gameManager isCurrentPlayerContainViking:tappedViking]){
        if ([tappedViking isActive]){
            [self.gameManager placeNeutral:tappedViking];
            [self showBoard];
        }else{
            if ([tappedViking isSelected]){
                [self setSelectedViking:nil];
                [self doubleTapOnViking:viking];
            }else{
                if (self.selectedViking != nil) [self.selectedViking setIsSelected:NO];
                [self setSelectedViking:tappedViking];
                [tappedViking setIsSelected:YES];
            }
        }
    }
}

-(void) doubleTapOnViking:(id) viking{
    NSLog(@"2Tap");
    Viking *tappedViking = viking;
    if ([self.gameManager canActivateViking:tappedViking]){
        [tappedViking setIsActive:true];
        [tappedViking setIsSelected:NO];
        [self.gameManager.dice removeDiceWithInt:1];
        
        CFBundleRef mainBundle = CFBundleGetMainBundle();
        CFURLRef soundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("piece"), CFSTR("aiff"), NULL);
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID(soundFileURLRef, &soundId);
        AudioServicesPlaySystemSound(soundId);
        CFRelease(soundFileURLRef);
        
        [self hideDices];
        [self showDices];
        if ([self.gameManager.dice isDicesEmpty]) [self nextTurn];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(void) activeSkip{
    if (![self.gameManager playerTurn]){
        [self.skipP1 setIsActive:YES];
    }else [self.skipP2 setIsActive:YES];
}

#pragma -
#pragma mark Neutral Viking Protocol

- (void) singleTapOnNeutralViking:(id)viking{
    NSLog(@"Tap on neutral");
    NeutralViking *tappedViking = viking;
    [self.gameManager killEnemy:tappedViking];
    //[self.selectedViking setCoords:[tappedViking coords]];
    [tappedViking.viking setCoords:[tappedViking coords]];
    [self.gameManager.dice removeDiceWithInt:[tappedViking usedDice]];
    [self hideDices];
    [self showDices];
    
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURLRef = CFBundleCopyResourceURL(mainBundle, CFSTR("piece"), CFSTR("aiff"), NULL);
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundId);
    AudioServicesPlaySystemSound(soundId);
    CFRelease(soundFileURLRef);
    
    for (NeutralViking *neutral in [self.gameManager neutrals]) {
        [neutral removeFromParent];
    }
    
    self.gameManager.neutrals = [[NSMutableArray alloc] init];
    if ([self.gameManager.dice isDicesEmpty]) [self nextTurn];
    [self showBoard];
    NSLog(@"Player one: %lu        Player two: %lu", (unsigned long)[self.gameManager.playerOne.gamePieces count], (unsigned long)[self.gameManager.playerTwo.gamePieces count]);
}

#pragma -
#pragma mark Show
-(void) showDices{
    
    if([self.gameManager playerTurn] == 1) {
        self.dice1.zRotation = M_PI;
        self.dice2.zRotation = M_PI;
    }
    if ([self.gameManager.dice firstDice] != 0)
        self.dice1.text = [NSString stringWithFormat:@"%d",self.gameManager.dice.firstDice];
    if ([self.gameManager.dice secondDice] != 0)
        self.dice2.text = [NSString stringWithFormat:@"%d",[self.gameManager.dice secondDice]];
}

-(void) hideDices{
    self.dice1.text = @"";
    self.dice1.zRotation = 0;
    self.dice2.text = @"";
    self.dice2.zRotation = 0;
}

-(void) showBoard{
    for (Viking *gamePiece in [self.gameManager.playerOne gamePieces]) {
        gamePiece.position = CGPointMake(self.boardRect.origin.x + self.boardRect.size.width/32 + gamePiece.coords.x*self.boardRect.size.width / 16,
                                         self.boardRect.origin.y + gamePiece.coords.y * self.boardRect.size.height / 3 + self.boardRect.size.height / 6);
        if ([self showBoardOnInit]) {
            [self.board addChild:gamePiece];
        }
    }
    
    
    for (Viking *gamePiece in [self.gameManager.playerTwo gamePieces]) {
        gamePiece.position = CGPointMake(self.boardRect.origin.x + self.boardRect.size.width/32 +gamePiece.coords.x*self.boardRect.size.width / 16,
                                         self.boardRect.origin.y + gamePiece.coords.y * self.boardRect.size.height / 3 + self.boardRect.size.height / 6);
        if ([self showBoardOnInit]) {
            [self.board addChild:gamePiece];
        }
    }
    
    for (NeutralViking *neutral in [self.gameManager neutrals]) {
        neutral.position = CGPointMake(self.boardRect.origin.x + self.boardRect.size.width/32 + neutral.coords.x*self.boardRect.size.width / 16,
                                       self.boardRect.origin.y + neutral.coords.y * self.boardRect.size.height / 3 + self.boardRect.size.height / 6);
        [neutral setScale:2 * (self.boardRect.size.height/10)/neutral.size.height];
        [neutral setZPosition:100];
        [neutral setDelegate:self];
        [self.board addChild:neutral];
    }
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
