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
	
	GameViewController *m_gvController;
}

- ( id ) initWithSize: ( CGSize ) size withBannerHeight: ( CGFloat ) bannerHeight withGameView: ( GameViewController* ) viewController {
	if ( self = [ super initWithSize: size ] ) {
		[ self setBackgroundColor: [ SKColor blackColor ] ];
		
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		SKNode *gameTitle = [ self getWrappingTextNode: @"Just About There" width: width * 0.8 height: 800 ];
		// SKLabelNode *gameTitle = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		// gameTitle.color = [ SKColor whiteColor ];
		// gameTitle.fontSize = 50.0f;
		// gameTitle.text = @"Just About There";
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
		m_gvController = viewController;
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
		[ self.view presentScene: [ [ GameScene alloc ] initWithSize: self.size withBannerHeight: m_bannerHeight withGameView: m_gvController ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	} else if ( CGRectContainsPoint( m_htpRect, location ) ) {
		[ self.view presentScene: [ [ HowToPlayScene alloc ] initWithSize: self.size mainMenu: self ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	} else if ( CGRectContainsPoint( m_leaderboardButton, location ) ) {
		if ( [ m_gvController gameCenterEnabled ] ) {
			[ m_gvController showLeaderboardAndAchievements: YES ];
		}
	}
}

- ( SKNode* ) getWrappingTextNode: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	UIImage *img = [ self drawText:text width: width height: height ];
	return [ SKSpriteNode spriteNodeWithTexture: [ SKTexture textureWithImage:img ] ];
}

- ( UIImage* ) drawText: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	NSMutableParagraphStyle *paragraphStyle = [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ];
	paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
	paragraphStyle.alignment = NSTextAlignmentCenter;
	paragraphStyle.firstLineHeadIndent = 0.5f;
	
	UIFont *font = [ UIFont fontWithName: GAME_FONT size: 50.0f ];
	
	UIColor *color = [ SKColor whiteColor ];
	NSDictionary *att = @{ NSForegroundColorAttributeName: color,  NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle };
	
	//using 800 here but make sure this height is greater than the potential height of the text (unless you want a max-height I guess but I did not test max-height)
	CGRect rect =  [ text boundingRectWithSize:CGSizeMake( width, 800 ) options: NSStringDrawingUsesLineFragmentOrigin attributes: att context: nil ];
	
	UIGraphicsBeginImageContextWithOptions( rect.size, NO, 0.0f );
	
	[ text drawInRect: rect withAttributes:att ];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

@end