//
//  GameViewController.m
//  Eyeball
//
//  Created by Craig Milby on 3/10/16.
//  Copyright (c) 2016 Craig Milby. All rights reserved.
//

#import "GameViewController.h"

#import "Constants.h"
#import "MainMenuScene.h"

@implementation GameViewController

- ( void ) viewDidLoad {
    [ super viewDidLoad ];
}

- ( void ) viewDidLayoutSubviews {
	[ super viewDidLayoutSubviews ];
	
	SKView *skView = ( SKView* ) self.view;
	// skView.showsFPS = YES;
	// skView.showsNodeCount = YES;
	
	if ( !skView.scene ) {
		skView.showsPhysics = YES;
		skView.ignoresSiblingOrder = YES;
	
		[ self authenticateLocalPlayer ];
		m_adView = [ [ ADBannerView alloc ] initWithFrame: CGRectZero ];
		
		MainMenuScene *scene = [ [ MainMenuScene alloc ] initWithSize: skView.bounds.size withBannerHeight: m_adView.bounds.size.height withGameView: self ];
		scene.scaleMode = SKSceneScaleModeAspectFill;
		
		[ skView presentScene:scene ];
		[ skView addSubview: m_adView ];
	}
}

- ( void ) authenticateLocalPlayer {
	GKLocalPlayer *player = [ GKLocalPlayer localPlayer ];
	
	player.authenticateHandler = ^( UIViewController *viewController, NSError *error ) {
		if ( viewController != nil ) {
			[ self presentViewController:viewController animated:YES completion:nil ];
		} else {
			if ( [ GKLocalPlayer localPlayer ].authenticated ) {
				m_gameCenterEnabled = YES;
			} else {
				m_gameCenterEnabled = NO;
			}
		}
	};
}

- ( void ) showLeaderboardAndAchievements: ( BOOL ) shouldShowLeaderboard {
	GKGameCenterViewController *gcViewController = [ [ GKGameCenterViewController alloc ] init ];
	
	gcViewController.gameCenterDelegate = self;
 
	if ( shouldShowLeaderboard ) {
		gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
		gcViewController.leaderboardIdentifier = ScoreLeaderboardID;
	} else {
		gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
	}
	
	[ self presentViewController: gcViewController animated: YES completion: nil ];
}

- ( void ) gameCenterViewControllerDidFinish: ( GKGameCenterViewController* ) gameCenterViewController {
	[ gameCenterViewController dismissViewControllerAnimated: YES completion: nil ];
}

- ( BOOL ) gameCenterEnabled {
	return m_gameCenterEnabled;
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
