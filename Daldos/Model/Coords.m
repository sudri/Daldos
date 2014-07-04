//
//  Coords.m
//  Daldos
//
//  Created by Эдуард Пятницын on 03.07.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "Coords.h"

@implementation Coords

-(void) setX:(int)x andSetY:(int)y{
    _x=x;
    _y=y;
}

-(id) initWithX:(int)x andY:(int)y{
    if (self = [super init]) {
        _x = x;
        _y = y;
    }
    return self;
}

-(BOOL) isEqual:(Coords *)object{
    if ((self.x == object.x) && (self.y == object.y)) {
        return YES;
    }
    return NO;
}
@end
