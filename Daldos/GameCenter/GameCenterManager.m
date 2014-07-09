//
//  GameCenterManager.m
//  Daldos
//
//  Created by Эдуард Пятницын on 04.07.14.
//  Copyright (c) 2014 com.EduardPyatnitsyn. All rights reserved.
//

#import "GameCenterManager.h"

#define playersCount 2

@implementation GameCenterManager

static GameCenterManager *sharedManager = nil;
+ (GameCenterManager *) sharedInstance {
    if (!sharedManager) {
        sharedManager = [[GameCenterManager alloc] init];
    }
    return sharedManager;
}

-(id) init{
        if ((self = [super init])) {
            if ([GameCenterManager isGameCenterAvailable]) {
                NSNotificationCenter *nc =
                [NSNotificationCenter defaultCenter];
                [nc addObserver:self
                       selector:@selector(authenticationChanged)
                           name:GKPlayerAuthenticationDidChangeNotificationName
                         object:nil];
            }
        }
        return self;
}

+ (BOOL)isGameCenterAvailable {
	// check for presence of GKLocalPlayer API
	Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
	
	// check if the device is running iOS 4.1 or later
	NSString *reqSysVer = @"4.1";
	NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
	BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
	
	return (gcClass && osVersionSupported);
}

- (void)authenticationChanged {
    NSLog(@"Auth changed");
}

-(void) authLocalUser{
	if([GKLocalPlayer localPlayer].authenticated == NO)
	{
        [[GKLocalPlayer localPlayer] setAuthenticateHandler:(^(UIViewController* viewcontroller, NSError *error) {
            if (!error && viewcontroller)
            {
                [self.vc presentViewController:viewcontroller animated:YES completion:nil];
            }
        })];
    }
}

-(void) findMatch{

    if ([GKLocalPlayer localPlayer].authenticated) {
        NSLog(@"find match");
        GKMatchRequest *request = [[GKMatchRequest alloc] init];
        request.minPlayers = playersCount;
        request.maxPlayers = playersCount;
        
        GKMatchmakerViewController *matchmakerVC =
        [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
        matchmakerVC.matchmakerDelegate = self;
        
        [self.vc presentViewController:matchmakerVC animated:YES completion:nil];
    }
}

- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController*)viewController
{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController
                didFailWithError:(NSError *)error
{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    [[[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController
                    didFindMatch:(GKMatch *)match
{
    [self.vc dismissViewControllerAnimated:YES completion:nil];
    //    GameScene *gameSceneVC=[self.storyboard instantiateViewControllerWithIdentifier:@"GameScene"];
    //    gameSceneVC.match=match;
    //    match.delegate = gameSceneVC;
    //    [self.navigationController pushViewController:gameSceneVC animated:YES];
}


@end
