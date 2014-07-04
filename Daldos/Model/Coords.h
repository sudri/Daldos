//
//  Coords.h
//  Daldos
//
//  Created by Эдуард Пятницын on 03.07.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coords : NSObject

@property (nonatomic) int x;
@property (nonatomic) int y;

-(void) setX:(int)x andSetY:(int)y;
-(id) initWithX:(int)x andY:(int)y;
-(BOOL) isEqual:(Coords *)object;

@end
