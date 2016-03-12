//
//  TriangleCenter.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "TriangleCenter.h"

@implementation TriangleCenter {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		m_p1 = CGPointMake( [ self randomFloatInRange: width * 0.15f max: width * 0.4f ], [ self randomFloatInRange: height * 0.15f max: height * 0.4f ] );
		m_p2 = CGPointMake( [ self randomFloatInRange: width * 0.15f max: width * 0.4f ], [ self randomFloatInRange: height * 0.6f max: height * 0.85f ] );
		m_p3 = CGPointMake( [ self randomFloatInRange: width * 0.6f max: width * 0.85f ], [ self randomFloatInRange: height * 0.2f max: height * 0.8f ] );
		
		CGFloat xActual = ( m_p1.x + m_p2.x + m_p3.x ) / 3.0f;
		CGFloat yActual = ( m_p1.y + m_p2.y + m_p3.y ) / 3.0f;
		m_actual = CGPointMake( xActual, yActual );
		m_point = CGPointMake( m_actual.x + [ self randomIntInRange: -30 max: 30 ], m_actual.y + [ self randomIntInRange: -30 max: 30 ] );
		
		m_shape = [ [ SKShapeNode alloc ] init ];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_p1.x, m_p1.y );
		CGPathAddLineToPoint( path, NULL, m_p2.x, m_p2.y );
		CGPathAddLineToPoint( path, NULL, m_p3.x, m_p3.y );
		CGPathAddLineToPoint( path, NULL, m_p1.x, m_p1.y );
		m_shape.path = path;
		m_shape.lineWidth = 2.0f;
		m_shape.strokeColor = [ SKColor whiteColor ];
		[ self addChild: m_shape ];
		
		m_cursor.position = m_actual;
		[ m_cursor setColor: [ SKColor grayColor ] ];
	}
	return self;
}

- ( void ) showActual {
	[ self addChild: m_cursor ];
}

@end