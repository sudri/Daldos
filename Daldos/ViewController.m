//
//  ViewController.m
//  Daldos
//
//  Created by Eduard Pyatnitsyn on 17.06.14.
//  Copyright (c) 2014 Eduard Pyatnitsyn. All rights reserved.
//

#import "ViewController.h"
#import "GameScene.h"
#import "GameOverScene.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(NSLocalizedString(@"language", nil));
    // Configure the view.
    SKView * skView =  (SKView *) self.view;
//    SKView *skView = [[SKView alloc] initWithFrame:self.view.frame];
//    [self addChildViewController:skView];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * gameScene = [GameScene sceneWithSize:skView.bounds.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:gameScene];
    

//    GameOverScene *newScene = [[GameOverScene alloc] initWithSize: skView.bounds.size  winner:1];
//    newScene.scaleMode = SKSceneScaleModeAspectFill;
//    [skView presentScene:newScene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
