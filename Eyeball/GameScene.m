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
#import "TriangleCenter.h"

@implementation GameScene {
	SKLabelNode *m_averageError;
	SKLabelNode *m_timeTaken;
	
	Cursor *m_cursor;
	
	NSMutableArray<Level*> *m_levels;
	int m_currentLevel;
}

- ( id ) initWithSize: ( CGSize ) size {
	if ( self = [ super initWithSize: size ] ) {
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		m_averageError = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_averageError.fontSize = height * FONT_SIZE;
		m_averageError.fontColor = [ SKColor blackColor ];
		
		m_timeTaken = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_timeTaken.fontSize = height * FONT_SIZE;
		m_timeTaken.fontColor = [ SKColor blackColor ];
		
		m_currentLevel = 2;
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
	}
	return self;
}

- ( void ) didMoveToView: ( SKView* ) view {
	UIPanGestureRecognizer *panGesture = [ [ UIPanGestureRecognizer alloc ] initWithTarget: self action: @selector( handlePan: ) ];
	[ view addGestureRecognizer: panGesture ];
}

- ( void ) handlePan: ( UIPanGestureRecognizer* ) sender {
	CGPoint location = [ sender locationInView: self.view ];
	location = CGPointMake( location.x, fabs( [ UIScreen mainScreen ].bounds.size.height - location.y ) );
	// location = CGPointMake( location.x / 2, location.y / 2 );
	
	if ( sender.state == UIGestureRecognizerStateEnded ) {
		[ [ m_levels objectAtIndex: m_currentLevel ] showActual ];
	} else if ( sender.state == UIGestureRecognizerStateBegan ) {
		m_firstTouch = CGPointMake( location.x, location.y );
		m_oldLoc = m_cursor.position;
	}
	
	CGPoint diff = CGPointMake( location.x - m_firstTouch.x, location.y - m_firstTouch.y );
	[ m_cursor setPosition: CGPointMake( m_oldLoc.x + diff.x, m_oldLoc.y + diff.y ) ];
	
	[ [ m_levels objectAtIndex: m_currentLevel ] setPoint: m_cursor.position ];
}

@end
