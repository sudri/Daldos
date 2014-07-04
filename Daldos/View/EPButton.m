//
//  EPButton.m
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 24.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

/*
 Usage
 EPButton *backButton = [[SKButton alloc] initWithImageNamedNormal:@"buttonNormal" selected:@"buttonSelected"];
 [backButton setPosition:CGPointMake(100, 100)];
 [backButton.title setText:@"Button"];
 [backButton.title setFontName:@"Chalkduster"];
 [backButton.title setFontSize:20.0];
 [backButton setTouchUpInsideTarget:self action:@selector(buttonAction)];
 [self addChild:backButton];
 
 */

#import "EPButton.h"
#import <objc/message.h>

@implementation EPButton

@synthesize isActive;

-(id) initWithActiveColor:(UIColor *)activeColor nonActiveColor:(UIColor *)nonActiveColor{
    if(self = [super init]){
        self.activeColor = activeColor;
        self.nonActiveColor = nonActiveColor;
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

-(BOOL) isActive{
    return isActive;
}


#pragma -
#pragma mark Setting Target-Action pairs

- (void)setTouchUpInsideTarget:(id)target action:(SEL)action {
    _targetTouchUpInside = target;
    _actionTouchUpInside = action;
}

- (void)setTouchDownTarget:(id)target action:(SEL)action {
    _targetTouchDown = target;
    _actionTouchDown = action;
}

- (void)setTouchUpTarget:(id)target action:(SEL)action {
    _targetTouchUp = target;
    _actionTouchUp = action;
}

#pragma -
#pragma mark Setter overrides

-(void) setIsActive:(BOOL)boolValue{
    if (boolValue){
        self.fontColor = self.activeColor;
        //self.isActive = isActive;
    }else{
        self.fontColor = self.nonActiveColor;
        //self.isActive = !isActive;
    }
    isActive = boolValue;
}




#pragma -
#pragma mark Touch Handling

/**
 * This method only occurs, if the touch was inside this node. Furthermore if
 * the Button is enabled, the texture should change to "selectedTexture".
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isActive]) {
        objc_msgSend(_targetTouchDown, _actionTouchDown);
        //[self setIsSelected:YES];
    }
}

/**
 * If the Button is enabled: This method looks, where the touch was moved to.
 * If the touch moves outside of the button, the isSelected property is restored
 * to NO and the texture changes to "normalTexture".
 */
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isActive]) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInNode:self.parent];
        
        if (CGRectContainsPoint(self.frame, touchPoint)) {
            //[self setIsSelected:YES];
        } else {
            //[self setIsSelected:NO];
        }
    }
}

/**
 * If the Button is enabled AND the touch ended in the buttons frame, the
 * selector of the target is run.
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self.parent];
    
    if ([self isActive] && CGRectContainsPoint(self.frame, touchPoint)) {
        objc_msgSend(_targetTouchUpInside, _actionTouchUpInside);
    }
    //[self setIsSelected:NO];
    objc_msgSend(_targetTouchUp, _actionTouchUp);
}
@end
