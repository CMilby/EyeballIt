//
//  GameScene.m
//  Eyeball
//
//  Created by Craig Milby on 3/10/16.
//  Copyright (c) 2016 Craig Milby. All rights reserved.
//

#import "GameScene.h"

#import "BisectAngle.h"
#import "Circle.h"
#import "Convergence.h"
#import "Cursor.h"
#import "GameDoneScene.h"
#import "LineMidpoint.h"
#import "Parallelogram.h"
#import "RightAngle.h"
#import "Stopwatch.h"
#import "TriangleCenter.h"

@implementation GameScene {
	SKLabelNode *m_averageError;
	SKLabelNode *m_timeTaken;
	
	SKLabelNode *m_nextLevel;
	SKSpriteNode *m_toNext;
	
	CGFloat m_bannerHeight;
	
	CGFloat m_totalError;
	NSMutableArray<NSNumber*> *m_errors;
	StopWatch *m_stopwatch;
	
	BOOL m_done;
	Cursor *m_cursor;
	
	NSMutableArray<Level*> *m_levels;
	int m_currentLevel;
	
	GameViewController *m_gvController;
}

- ( id ) initWithSize: ( CGSize ) size withBannerHeight: ( CGFloat ) bannerHeight withGameView: ( GameViewController* ) viewController {
	if ( self = [ super initWithSize: size ] ) {
		[ self setBackgroundColor: [ SKColor blackColor ] ];
		
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		m_averageError = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_averageError.fontSize = height * FONT_SIZE;
		m_averageError.fontColor = [ SKColor blackColor ];
		
		m_timeTaken = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_timeTaken.fontSize = height * FONT_SIZE;
		m_timeTaken.fontColor = [ SKColor blackColor ];
		
		m_currentLevel = 0;
		m_levels = [ [ NSMutableArray alloc ] initWithCapacity: 7 ];
		[ m_levels addObject: [ [ Parrallogram alloc ] init: bannerHeight ] ];
		[ m_levels addObject: [ [ LineMidpoint alloc ] init: bannerHeight ] ];
		[ m_levels addObject: [ [ BisectAngle alloc ] init: bannerHeight ] ];
		[ m_levels addObject: [ [ TriangleCenter alloc ] init: bannerHeight ] ];
		[ m_levels addObject: [ [ Circle alloc ] init: bannerHeight ] ];
		[ m_levels addObject: [ [ RightAngle alloc ] init: bannerHeight ] ];
		[ m_levels addObject: [ [ Convergence alloc ] init: bannerHeight ] ];
		
		[ self addChild: [ m_levels objectAtIndex: m_currentLevel ] ];
		
		m_cursor = [ [ Cursor alloc ] init ];
		m_cursor.position = [ [ m_levels objectAtIndex: m_currentLevel ] point ];
		[ self addChild: m_cursor ];
		
		m_done = false;
		
		m_averageError = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_averageError.text = @"Average Error: 0.00";
		m_averageError.color = [ SKColor whiteColor ];
		m_averageError.fontSize = height * FONT_SIZE;
		m_averageError.position = CGPointMake( width * FONT_SIZE, ( height * FONT_SIZE ) );
		m_averageError.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
		[ self addChild: m_averageError ];
		
		m_timeTaken = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_timeTaken.text = @"Time Taken: 0.0";
		m_timeTaken.color = [ SKColor whiteColor ];
		m_timeTaken.fontSize = height * FONT_SIZE;
		m_timeTaken.position = CGPointMake( width * FONT_SIZE, ( ( height * FONT_SIZE ) * 2 ) );
		m_timeTaken.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
		[ self addChild: m_timeTaken ];
		
		m_stopwatch = [ [ StopWatch alloc ] init ];
		
		m_nextLevel = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_nextLevel.fontSize = FONT_SIZE * height;
		m_nextLevel.fontColor = [ SKColor whiteColor ];
		m_nextLevel.text = @"Tap to go to next level";
		m_nextLevel.position = CGPointMake( width / 2, height - ( ( FONT_SIZE * height ) * 1.5f ) - bannerHeight );
		
		m_totalError = 0.0f;
		m_errors = [ [ NSMutableArray alloc ] initWithCapacity: [ m_levels count ] ];
		
		m_bannerHeight = bannerHeight;
		m_gvController = viewController;
	}
	return self;
}

- ( void ) didMoveToView: ( SKView* ) view {
	UIPanGestureRecognizer *panGesture = [ [ UIPanGestureRecognizer alloc ] initWithTarget: self action: @selector( handlePan: ) ];
	[ view addGestureRecognizer: panGesture ];
	
	UITapGestureRecognizer *tapGesture = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
	[ tapGesture requireGestureRecognizerToFail: panGesture ];
	[ view addGestureRecognizer: tapGesture ];
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
	if ( !m_done ) {
		return;
	}
	
	if ( m_currentLevel < [ m_levels count ] - 1 ) {
		if ( [ m_nextLevel parent ] != nil ) {
			[ m_nextLevel removeFromParent ];
		}
		
		m_done = false;
		[ [ m_levels objectAtIndex: m_currentLevel ] removeFromParent ];
		m_currentLevel++;
		[ m_cursor setPosition: [ [ m_levels objectAtIndex: m_currentLevel ] point ] ];
		[ self addChild: [ m_levels objectAtIndex: m_currentLevel ] ];
	} else {
		[ self.view presentScene: [ [ GameDoneScene alloc ] initWithSize: self.size withTime: [ m_stopwatch timeString ] withTotalError: m_totalError withErrors: m_errors bannerHeight: m_bannerHeight withGameView: m_gvController ] transition: [ SKTransition fadeWithColor: [ SKColor blackColor ] duration: 0.5f ] ];
	}
}

- ( void ) handlePan: ( UIPanGestureRecognizer* ) sender {
	if ( m_done ){
		return;
	}
	
	CGPoint location = [ sender locationInView: self.view ];
	location = CGPointMake( location.x, fabs( [ UIScreen mainScreen ].bounds.size.height - location.y ) );
	// location = CGPointMake( location.x / 2, location.y / 2 );
	
	if ( sender.state == UIGestureRecognizerStateEnded ) {
		[ m_stopwatch stop ];
		[ [ m_levels objectAtIndex: m_currentLevel ] showActual ];
		m_totalError += [ [ m_levels objectAtIndex: m_currentLevel ] errorMargin ];
		m_averageError.text = [ NSString stringWithFormat: @"Average Error: %.02f", m_totalError / ( m_currentLevel + 1 ) ];
		[ m_errors addObject: [ NSNumber numberWithFloat: [ [ m_levels objectAtIndex: m_currentLevel ] errorMargin ] ] ];
		m_done = true;
		
		if ( m_currentLevel == 6 ) {
			m_nextLevel.text = @"Tap to see game details";
		}
		[ self addChild: m_nextLevel ];
		return;
	} else if ( sender.state == UIGestureRecognizerStateBegan ) {
		m_firstTouch = CGPointMake( location.x, location.y );
		m_oldLoc = m_cursor.position;
		[ m_stopwatch start ];
		return;
	}
	
	CGPoint diff = CGPointMake( location.x - m_firstTouch.x, location.y - m_firstTouch.y );
	[ m_cursor setPosition: CGPointMake( m_oldLoc.x + diff.x, m_oldLoc.y + diff.y ) ];
	
	[ [ m_levels objectAtIndex: m_currentLevel ] setPoint: m_cursor.position ];
}

- ( void ) update: ( NSTimeInterval ) currentTime {
	m_timeTaken.text = [ NSString stringWithFormat: @"Time Taken: %@", [ m_stopwatch timeString ] ];
}

@end
