//
//  IntroScene.m
//  Daldos
//
//  Created by Эдуард Пятницын on 04.07.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "IntroScene.h"
#import "EPButton.h"

@implementation IntroScene

-(id) initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        self.scaleMode = SKSceneScaleModeAspectFill;
        
    }
    return self;
}

@end
