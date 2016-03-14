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
#import "Constants.h"
#import "Convergence.h"
#import "Cursor.h"
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
	
	CGFloat m_avgError;
	CGFloat m_time;
	StopWatch *m_stopwatch;
	
	BOOL m_done;
	Cursor *m_cursor;
	
	NSMutableArray<Level*> *m_levels;
	int m_currentLevel;
}

- ( id ) initWithSize: ( CGSize ) size {
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
		[ m_levels addObject: [ [ Parrallogram alloc ] init ] ];
		[ m_levels addObject: [ [ LineMidpoint alloc ] init ] ];
		[ m_levels addObject: [ [ BisectAngle alloc ] init ] ];
		[ m_levels addObject: [ [ TriangleCenter alloc ] init ] ];
		[ m_levels addObject: [ [ Circle alloc ] init ] ];
		[ m_levels addObject: [ [ RightAngle alloc ] init ] ];
		[ m_levels addObject: [ [ Convergence alloc ] init ] ];
		
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
		m_timeTaken.text = @"Time Taken: 0:0.00";
		m_timeTaken.color = [ SKColor whiteColor ];
		m_timeTaken.fontSize = height * FONT_SIZE;
		m_timeTaken.position = CGPointMake( width * FONT_SIZE, ( ( height * FONT_SIZE ) * 2 ) );
		m_timeTaken.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
		[ self addChild: m_timeTaken ];
		
		m_stopwatch = [ [ StopWatch alloc ] init ];
		
		m_avgError = 0.0f;
		m_time = 0.0f;
		
		m_nextLevel = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_nextLevel.fontSize = FONT_SIZE * height;
		m_nextLevel.fontColor = [ SKColor whiteColor ];
		m_nextLevel.text = @"Tap to go to next level";
		m_nextLevel.position = CGPointMake( width / 2, height - ( ( FONT_SIZE * height ) * 1.5f ) );
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
	
	if ( [ m_nextLevel parent ] != nil ) {
		[ m_nextLevel removeFromParent ];
	}
	
	m_done = false;
	[ [ m_levels objectAtIndex: m_currentLevel ] removeFromParent ];
	m_currentLevel++;
	[ m_cursor setPosition: [ [ m_levels objectAtIndex: m_currentLevel ] point ] ];
	[ self addChild: [ m_levels objectAtIndex: m_currentLevel ] ];
}

- ( void ) handlePan: ( UIPanGestureRecognizer* ) sender {
	if ( m_done ){
		return;
	}
	
	CGPoint location = [ sender locationInView: self.view ];
	location = CGPointMake( location.x, fabs( [ UIScreen mainScreen ].bounds.size.height - location.y ) );
	// location = CGPointMake( location.x / 2, location.y / 2 );
	
	if ( sender.state == UIGestureRecognizerStateEnded ) {
		[ [ m_levels objectAtIndex: m_currentLevel ] showActual ];
		m_avgError += [ [ m_levels objectAtIndex: m_currentLevel ] errorMargin ];
		m_averageError.text = [ NSString stringWithFormat: @"Average Error: %.02f", m_avgError / ( m_currentLevel + 1 ) ];
		m_done = true;
		[ m_stopwatch stop ];
		[ self addChild: m_nextLevel ];
	} else if ( sender.state == UIGestureRecognizerStateBegan ) {
		m_firstTouch = CGPointMake( location.x, location.y );
		m_oldLoc = m_cursor.position;
		[ m_stopwatch start ];
	}
	
	CGPoint diff = CGPointMake( location.x - m_firstTouch.x, location.y - m_firstTouch.y );
	[ m_cursor setPosition: CGPointMake( m_oldLoc.x + diff.x, m_oldLoc.y + diff.y ) ];
	
	[ [ m_levels objectAtIndex: m_currentLevel ] setPoint: m_cursor.position ];
}

- ( void ) update: ( NSTimeInterval ) currentTime {
	m_timeTaken.text = [ NSString stringWithFormat: @"Time Taken: %@", [ m_stopwatch timeString ] ];
}

@end
