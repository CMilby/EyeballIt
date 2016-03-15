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
		
		m_nextButtonRect = CGRectMake( width / 2 + 10, 10.0f, width / 2 - 20, height / 10 );
		SKShapeNode *nextBut = [ SKShapeNode shapeNodeWithRect: m_nextButtonRect ];
		nextBut.lineWidth = 2.0f;
		nextBut.strokeColor = [ SKColor whiteColor ];
		[ self addChild: nextBut ];
		
		SKLabelNode *nextLbl = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		nextLbl.fontSize = height * FONT_SIZE;
		nextLbl.fontColor = [ SKColor whiteColor ];
		nextLbl.text = @"Next";
		nextLbl.position = CGPointMake( CGRectGetMidX( m_nextButtonRect ), CGRectGetMidY( m_nextButtonRect ) - ( height * FONT_SIZE / 3 ) );
		[ self addChild: nextLbl ];
		
		SKNode *text = [ self getWrappingTextNode: @"This is an example of wrapping text that I hope will actually wrap. I guess we will find out" width: width height: height ];
		text.position = CGPointMake( width / 2, height / 2);
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
	} else if ( CGRectContainsPoint( m_nextButtonRect, location ) ) {
		
	}
}

- ( SKNode* ) getWrappingTextNode: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	UIImage *img = [ self drawText:text width: width height: height ];
	return [ SKSpriteNode spriteNodeWithTexture: [ SKTexture textureWithImage:img ] ];
}

- ( UIImage* ) drawText: ( NSString* ) text width: ( CGFloat ) width height: ( CGFloat ) height {
	NSMutableParagraphStyle *paragraphStyle = [ [ NSParagraphStyle defaultParagraphStyle ] mutableCopy ];
	paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
	paragraphStyle.alignment = NSTextAlignmentJustified;
	
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