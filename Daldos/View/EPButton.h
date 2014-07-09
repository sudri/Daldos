//
//  EPButton.h
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 24.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface EPButton : SKLabelNode

//@property (nonatomic) bool isActive;

@property(nonatomic) BOOL isActive;
@property (nonatomic) SKColor *activeColor;
@property (nonatomic) SKColor *nonActiveColor;

@property (nonatomic, readonly) SEL actionTouchUpInside;
@property (nonatomic, readonly) SEL actionTouchDown;
@property (nonatomic, readonly) SEL actionTouchUp;
@property (nonatomic, readonly, weak) id targetTouchUpInside;
@property (nonatomic, readonly, weak) id targetTouchDown;
@property (nonatomic, readonly, weak) id targetTouchUp;

-(id) initWithActiveColor:(SKColor *)activeColor nonActiveColor:(SKColor *)nonActiveColor;


/** Sets the target-action pair, that is called when the Button is tapped.
 "target" won't be retained.
 */
- (void)setTouchUpInsideTarget:(id)target action:(SEL)action;
- (void)setTouchDownTarget:(id)target action:(SEL)action;
- (void)setTouchUpTarget:(id)target action:(SEL)action;

@end
