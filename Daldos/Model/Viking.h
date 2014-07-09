//
//  Viking.h
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 17.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Coords.h"

@protocol Viking

- (void) singleTapOnViking: (id) viking;
- (void) doubleTapOnViking: (id) viking;
@end;

@interface Viking : SKSpriteNode



@property id delegate;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) UIColor *color;
@property (nonatomic) Coords *coords;

-(id) initWithColor:(UIColor *) color;

@end
