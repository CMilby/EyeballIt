//
//  GameViewController.h
//  Eyeball
//

//  Copyright (c) 2016 Craig Milby. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <iAd/iAd.h>
#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController<ADBannerViewDelegate, GKGameCenterControllerDelegate> {
	BOOL m_gameCenterEnabled;
	ADBannerView *m_adView;
}

- ( void ) authenticateLocalPlayer;

- ( void ) showLeaderboardAndAchievements: ( BOOL ) shouldShowLeaderboard;

- ( BOOL ) gameCenterEnabled;

@end
