//
//  GameViewController.m
//  Eyeball
//
//  Created by Craig Milby on 3/10/16.
//  Copyright (c) 2016 Craig Milby. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- ( void ) viewDidLoad {
    [ super viewDidLoad ];
}

- ( void ) viewDidLayoutSubviews {
	[ super viewDidLayoutSubviews ];
	
	SKView *skView = (SKView* ) self.view;
	skView.showsFPS = YES;
	skView.showsNodeCount = YES;
	skView.showsPhysics = YES;
	skView.ignoresSiblingOrder = YES;
	
	GameScene *scene = [ GameScene sceneWithSize: skView.bounds.size ];
	scene.scaleMode = SKSceneScaleModeAspectFill;
	
	[ skView presentScene:scene ];
}

- ( BOOL ) shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
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

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
