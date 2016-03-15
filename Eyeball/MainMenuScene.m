//
//  MainMenuScene.m
//  Eyeball
//
//  Created by Craig Milby on 3/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "MainMenuScene.h"

#import "GameScene.h"
#import "HowToPlayScene.h"

@implementation MainMenuScene {
	CGRect m_buttonRect;
	CGRect m_htpRect;
	CGRect m_leaderboardButton;
	
	CGFloat m_bannerHeight;
}

- ( id ) initWithSize: ( CGSize ) size withBannerHeight: ( CGFloat ) bannerHeight {
	if ( self = [ super initWithSize: size ] ) {
		[ self setBackgroundColor: [ SKColor blackColor ] ];
		
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		SKLabelNode *gameTitle = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		gameTitle.color = [ SKColor whiteColor ];
		gameTitle.fontSize = 64.0f;
		gameTitle.text = @"Eyeball It";
		gameTitle.position = CGPointMake( width / 2, height / 4 * 3 );
		[ self addChild: gameTitle ];
		
		m_buttonRect = CGRectMake( width / 8, height / 6 * 3, width / 8 * 6, height / 10 );
		SKShapeNode *playbutton = [ SKShapeNode shapeNodeWithRect: m_buttonRect ];
		playbutton.strokeColor = [ SKColor whiteColor ];
		playbutton.lineWidth = 2.0f;
		[ self addChild: playbutton ];
		
		SKLabelNode *playText = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		playText.color = [ SKColor whiteColor ];
		playText.fontSize = height * FONT_SIZE;
		playText.text = @"Play Game";
		playText.position = CGPointMake( width / 2, CGRectGetMidY( m_buttonRect ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: playText ];
		
		m_htpRect = CGRectMake( width / 8, height / 6 * 2, width / 8 * 6, height / 10 );
		SKShapeNode *htpButton = [ SKShapeNode shapeNodeWithRect: m_htpRect ];
		htpButton.strokeColor = [ SKColor whiteColor ];
		htpButton.lineWidth = 2.0f;
		[ self addChild: htpButton ];
		
		SKLabelNode *htpText = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		htpText.fontColor = [ SKColor whiteColor ];
		htpText.text = @"How To Play";
		htpText.fontSize = height * FONT_SIZE;
		htpText.position = CGPointMake( width / 2, CGRectGetMidY( m_htpRect ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: htpText ];
		
		m_leaderboardButton = CGRectMake( width / 8, height / 6, width / 8 * 6, height / 10 );
		SKShapeNode *leaderboardShape = [ SKShapeNode shapeNodeWithRect: m_leaderboardButton ];
		leaderboardShape.strokeColor = [ SKColor whiteColor ];
		leaderboardShape.lineWidth = 2.0f;
		[ self addChild: leaderboardShape ];
		
		SKLabelNode *leaderboardTxt = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		leaderboardTxt.text = @"Leaderboards";
		leaderboardTxt.fontColor = [ SKColor whiteColor ];
		leaderboardTxt.fontSize = height * FONT_SIZE;
		leaderboardTxt.position = CGPointMake( width / 2, CGRectGetMidY( m_leaderboardButton ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: leaderboardTxt ];
		
		m_bannerHeight = bannerHeight;
	}
	return self;
}

- ( void ) didMoveToView: ( SKView* ) view {
	UITapGestureRecognizer *tapGesture = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
	[ view addGestureRecognizer: tapGesture ];
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
	CGPoint location = [ sender locationInView: self.view ];
	location = CGPointMake( location.x, fabs( [ UIScreen mainScreen ].bounds.size.height - location.y ) );
	
	if ( CGRectContainsPoint( m_buttonRect, location ) ) {
		[ self.view presentScene: [ [ GameScene alloc ] initWithSize: self.size withBannerHeight: m_bannerHeight ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	} else if ( CGRectContainsPoint( m_htpRect, location ) ) {
		[ self.view presentScene: [ [ HowToPlayScene alloc ] initWithSize: self.size mainMenu: self ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	} else if ( CGRectContainsPoint( m_leaderboardButton, location ) ) {
		// Show leaderboards
	}
}

@end