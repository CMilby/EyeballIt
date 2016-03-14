//
//  GameViewController.m
//  Eyeball
//
//  Created by Craig Milby on 3/10/16.
//  Copyright (c) 2016 Craig Milby. All rights reserved.
//

#import "GameViewController.h"
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
		
		MainMenuScene *scene = [ [ MainMenuScene alloc ] initWithSize: skView.bounds.size withBannerHeight: m_adView.bounds.size.height ];
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
				
				// Get the default leaderboard identifier.
				[ [ GKLocalPlayer localPlayer ] loadDefaultLeaderboardIdentifierWithCompletionHandler: ^( NSString *leaderboardIdentifier, NSError *error ) {
					
					if ( error != nil ) {
						NSLog( @"%@", [ error localizedDescription ] );
					} else {
						m_leaderboardIdentifier = leaderboardIdentifier;
					}
				}];
			} else {
				m_gameCenterEnabled = NO;
			}
		}
	};
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
