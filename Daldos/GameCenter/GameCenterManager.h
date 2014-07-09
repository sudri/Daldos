//
//  GameCenterManager.h
//  Daldos
//
//  Created by Эдуард Пятницын on 04.07.14.
//  Copyright (c) 2014 com.EduardPyatnitsyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "ViewController.h"

@interface GameCenterManager : NSObject <GKMatchmakerViewControllerDelegate> {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
    
    GKMatch *match;
    BOOL matchStarted;
    id delegate;
}

@property ViewController *vc;

+ (GameCenterManager *) sharedInstance;
+ (BOOL)isGameCenterAvailable;

-(void) authLocalUser;
-(void) authenticationChanged;
-(void) findMatch;

@end
