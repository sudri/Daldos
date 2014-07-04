//
//  Dice.h
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 26.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>
/**

 @header
  Game dices logic
 */
@interface Dice : NSObject

@property (nonatomic) int firstDice;
@property (nonatomic) int secondDice;
@property (nonatomic) BOOL rolled;

-(void) rollDices;
-(BOOL) removeDiceWithInt: (int) num;
-(BOOL) diceContainDal;
-(BOOL) isDicesEmpty;
-(int) count;
@end
