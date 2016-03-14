//
//  MainMenuScene.m
//  Eyeball
//
//  Created by Craig Milby on 3/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "MainMenuScene.h"

#import "GameScene.h"

@implementation MainMenuScene {
	SKLabelNode *m_gameTitle;
	
	CGRect m_buttonRect;
	CGRect m_htpRect;
	
	SKShapeNode *m_htpButton;
	SKLabelNode *m_htpText;
	
	SKShapeNode *m_playbutton;
	SKLabelNode *m_playText;
	
	CGFloat m_bannerHeight;
}

- ( id ) initWithSize: ( CGSize ) size withBannerHeight: ( CGFloat ) bannerHeight {
	if ( self = [ super initWithSize: size ] ) {
		[ self setBackgroundColor: [ SKColor blackColor ] ];
		
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		m_gameTitle = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_gameTitle.color = [ SKColor whiteColor ];
		m_gameTitle.fontSize = 64.0f;
		m_gameTitle.text = @"Eyeball It";
		m_gameTitle.position = CGPointMake( width / 2, height / 4 * 3 );
		[ self addChild: m_gameTitle ];
		
		m_buttonRect = CGRectMake( width / 8, height / 6 * 3, width / 8 * 6, height / 10 );
		m_playbutton = [ SKShapeNode shapeNodeWithRect: m_buttonRect ];
		m_playbutton.strokeColor = [ SKColor whiteColor ];
		m_playbutton.lineWidth = 2.0f;
		[ self addChild: m_playbutton ];
		
		m_playText = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_playText.color = [ SKColor whiteColor ];
		m_playText.fontSize = height * FONT_SIZE;
		m_playText.text = @"Play Game";
		m_playText.position = CGPointMake( width / 2, CGRectGetMidY( m_buttonRect ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: m_playText ];
		
		m_htpRect = CGRectMake( width / 8, height / 6 * 2, width / 8 * 6, height / 10 );
		m_htpButton = [ SKShapeNode shapeNodeWithRect: m_htpRect ];
		m_htpButton.strokeColor = [ SKColor whiteColor ];
		m_htpButton.lineWidth = 2.0f;
		[ self addChild: m_htpButton ];
		
		m_htpText = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_htpText.color = [ SKColor whiteColor ];
		m_htpText.text = @"How To Play";
		m_htpText.fontSize = height * FONT_SIZE;
		m_htpText.position = CGPointMake( width / 2, CGRectGetMidY( m_htpRect ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: m_htpText ];
		
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
	location = CGPointMake( location.y, fabs( [ UIScreen mainScreen ].bounds.size.height - location.y ) );
	
	if ( CGRectContainsPoint( m_buttonRect, location ) ) {
		[ self.view presentScene: [ [ GameScene alloc ] initWithSize: self.size withBannerHeight: m_bannerHeight ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	} else if ( CGRectContainsPoint( m_htpRect, location ) ) {
		// How to play scene?
	}
}

@end