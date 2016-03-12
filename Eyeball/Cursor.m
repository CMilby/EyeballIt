//
//  Cursor.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "Cursor.h"

@implementation Cursor {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		m_cursorFrame = [ SKShapeNode shapeNodeWithRect: CGRectMake( -10, -10, 20, 20 ) ];
		m_cursorFrame.lineWidth = 1.0f;
		m_cursorFrame.strokeColor =  [ SKColor whiteColor ];
		[ self addChild: m_cursorFrame ];
		
		m_crosshair = [ [ SKShapeNode alloc ] init ];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, 0, -5 );
		CGPathAddLineToPoint( path, NULL, 0, 5 );
		CGPathMoveToPoint( path, NULL, -5, 0 );
		CGPathAddLineToPoint( path, NULL, 5, 0 );
		m_crosshair.path = path;
		m_crosshair.lineWidth = 1.0f;
		m_crosshair.strokeColor = [ SKColor lightGrayColor ];
		[ self addChild: m_crosshair ];
	}
	return self;
}

- ( void ) setColor: ( UIColor* ) color {
	m_crosshair.strokeColor = color;
	m_cursorFrame.strokeColor = color;
}

@end