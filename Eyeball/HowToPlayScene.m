//
//  HowToPlayScene.m
//  Eyeball
//
//  Created by Craig Milby on 3/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "HowToPlayScene.h"

@implementation HowToPlayScene {
	SKLabelNode *m_title;
	
	CGRect m_backButtonRect;
	CGRect m_nextButtonRect;
}

- ( id ) initWithSize: ( CGSize ) size mainMenu: ( MainMenuScene* ) scene {
	if ( self = [ super initWithSize: size ] ) {
		m_mainMenu = scene;
		
		[ self setBackgroundColor: [ SKColor blackColor ] ];
		
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		SKNode *gameTitle = [ self getWrappingTextTitle: @"Just About There" width: width * 0.8 height: 800 ];
		// SKLabelNode *gameTitle = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		// gameTitle.color = [ SKColor whiteColor ];
		// gameTitle.fontSize = 50.0f;
		// gameTitle.text = @"Just About There";
		gameTitle.position = CGPointMake( width / 2, height / 4 * 3 );
		[ self addChild: gameTitle ];
		
		m_backButtonRect = CGRectMake( 10.0f, 10.0f, width / 2 - 20, height / 10 );
		SKShapeNode *backBut = [ SKShapeNode shapeNodeWithRect: m_backButtonRect ];
		backBut.lineWidth = 2.0f;
		backBut.strokeColor = [ SKColor whiteColor ];
		[ self addChild: backBut ];
		
		SKLabelNode *backLbl = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		backLbl.fontSize = height * FONT_SIZE;
		backLbl.fontColor = [ SKColor whiteColor ];
		backLbl.text = @"Back";
		backLbl.position = CGPointMake( CGRectGetMidX( m_backButtonRect ), CGRectGetMidY( m_backButtonRect ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: backLbl ];
		
		SKNode *text = [ self getWrappingTextNode: @"The purpose of the game is make the specified shape as accurately as you possibly can. In order to tdo this, press your finger anywhere on the screen. Then, without lifting you finger, move it around to change the shapes shape. In order to get the best score, you want to make the shape as close to the actual shope as possible while doing so as quickly as possible. Good luck!" width: width * 0.8 height: height ];
		text.position = CGPointMake( width / 2, height / 3 * 1.25 );
		[ self addChild: text ];
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

	if ( CGRectContainsPoint( m_backButtonRect, location ) ) {
		[ self.view presentScene: m_mainMenu transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	}
}

- ( SKNode* ) getWrappingTextTitle: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	UIImage *img = [ self drawTextTitle: text width: width height: height ];
	return [ SKSpriteNode spriteNodeWithTexture: [ SKTexture textureWithImage:img ] ];
}

- ( UIImage* ) drawTextTitle: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
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

- ( SKNode* ) getWrappingTextNode: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	UIImage *img = [ self drawText:text width: width height: height ];
	return [ SKSpriteNode spriteNodeWithTexture: [ SKTexture textureWithImage:img ] ];
}

- ( UIImage* ) drawText: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	NSMutableParagraphStyle *paragraphStyle = [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ];
	paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
	paragraphStyle.alignment = NSTextAlignmentJustified;
	paragraphStyle.firstLineHeadIndent = 0.5f;
	
	UIFont *font = [ UIFont fontWithName: GAME_FONT size: FONT_SIZE * height ];

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