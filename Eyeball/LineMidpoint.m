//
//  LineMidpoint.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "LineMidpoint.h"

@implementation LineMidpoint {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		[ self setName: @"LineMidpoint" ];
		
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		
		m_line1Start = CGPointMake( [ self randomFloatInRange: width * 0.2f max: width * 0.8f ], [ self randomFloatInRange: height * 0.2f max: height * 0.4f ] );
		m_line2Start = CGPointMake( [ self randomFloatInRange: width * 0.2f max: width * 0.8f ], [ self randomFloatInRange: height * 0.6f max: height * 0.8f ] );
		
		m_actual = [ self midpoint: m_line1Start p2: m_line2Start ];
		m_point = CGPointMake( m_actual.x + [ self randomIntInRange: 5 max: 30 ], m_actual.y + [ self randomIntInRange: 5 max: 30 ] );
		
		m_line1 = [ [ SKShapeNode alloc ] init ];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_line1Start.x, m_line1Start.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line1.path = path;
		m_line1.lineWidth = 2.0f;
		m_line1.strokeColor = [ SKColor whiteColor ];
		m_line1.zPosition = 3.0f;
		[ self addChild: m_line1 ];
		
		m_line2 = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_line2Start.x, m_line2Start.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line2.path = path;
		m_line2.lineWidth = 2.0f;
		m_line2.strokeColor = [ SKColor whiteColor ];
		m_line2.zPosition = 3.0f;
		[ self addChild: m_line2 ];
		
		m_actualLine = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_line1Start.x, m_line1Start.y );
		CGPathAddLineToPoint( path, NULL, m_line2Start.x, m_line2Start.y );
		m_actualLine.path = path;
		m_actualLine.lineWidth = 2.0f;
		m_actualLine.strokeColor = [ SKColor grayColor ];
		
		m_cursor.position = m_actual;
		[ m_cursor setColor: [ SKColor whiteColor ] ];
	}
	return self;
}

- ( void ) setPoint: ( CGPoint ) point {
	m_point = point;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint( path, NULL, m_line1Start.x, m_line1Start.y );
	CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
	m_line1.path = path;
	
	path = CGPathCreateMutable();
	CGPathMoveToPoint( path, NULL, m_line2Start.x, m_line2Start.y );
	CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
	m_line2.path = path;
}

- ( void ) showActual {
	[ self addChild: m_cursor ];
	[ self addChild: m_actualLine ];
}

@end