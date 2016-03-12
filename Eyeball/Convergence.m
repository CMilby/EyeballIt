//
//  Convergence.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "Convergence.h"

@implementation Convergence {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		m_actual = CGPointMake( [ self randomFloatInRange: width * 0.4f max: width * 0.6f ], [ self randomFloatInRange: height * 0.4f max: height * 0.6f ] );
		m_point = CGPointMake( m_actual.x + [ self randomIntInRange: -30 max: 30 ], m_actual.y + [ self randomIntInRange: -30 max: 30 ] );
		
		CGFloat angle1;
		CGFloat angle2;
		CGFloat angle3;
		
		if ( [ self randomFloatInRange: 0.0f max: 1.0f ] > 0.5f ) {
			angle1 = [ self randomFloatInRange: 0.0f max: 70.0f ];
			angle2 = [ self randomFloatInRange: 70.0f max: 140.0f ];
			angle3 = [ self randomFloatInRange: 140.0f max: 200.0f ];
		} else {
			angle1 = [ self randomFloatInRange: -70.0f max: 0.0f ];
			angle2 = [ self randomFloatInRange: -140.0f max: -70.0f ];
			angle3 = [ self randomFloatInRange: -200.0f max: -140.0f ];
		}
		
		CGFloat offset = width * 0.35f;
		
		CGPoint p1On =  [ self rotate: m_actual angle: angle1 point: CGPointMake( m_actual.x, m_actual.y + offset ) ];
		CGPoint p1Off = [ self rotate: m_actual angle: angle1 point: CGPointMake( m_actual.x, m_actual.y + height ) ];
		CGPoint p2On =  [ self rotate: m_actual angle: angle2 point: CGPointMake( m_actual.x, m_actual.y + offset ) ];
		CGPoint p2Off = [ self rotate: m_actual angle: angle2 point: CGPointMake( m_actual.x, m_actual.y + height ) ];
		CGPoint p3On =  [ self rotate: m_actual angle: angle3 point: CGPointMake( m_actual.x, m_actual.y + offset ) ];
		CGPoint p3Off = [ self rotate: m_actual angle: angle3 point: CGPointMake( m_actual.x, m_actual.y + height ) ];
		
		m_line1Start = p1On;
		m_line2Start = p2On;
		m_line3Start = p3On;
		
		m_shape = [ [ SKShapeNode alloc ] init ];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, p1Off.x, p1Off.y );
		CGPathAddLineToPoint( path, NULL, p1On.x, p1On.y );
		CGPathMoveToPoint( path, NULL, p2Off.x, p2Off.y );
		CGPathAddLineToPoint( path, NULL, p2On.x, p2On.y );
		CGPathMoveToPoint( path, NULL, p3Off.x, p3Off.y );
		CGPathAddLineToPoint( path, NULL, p3On.x, p3On.y );
		m_shape.path = path;
		m_shape.lineWidth = 2.0f;
		m_shape.strokeColor = [ SKColor whiteColor ];
		m_shape.zPosition = 3.0f;
		[ self addChild: m_shape ];
		
		m_actualShape = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, p1Off.x, p1Off.y );
		CGPathAddLineToPoint( path, NULL, m_actual.x, m_actual.y );
		CGPathMoveToPoint( path, NULL, p2Off.x, p2Off.y );
		CGPathAddLineToPoint( path, NULL, m_actual.x, m_actual.y );
		CGPathMoveToPoint( path, NULL, p3Off.x, p3Off.y );
		CGPathAddLineToPoint( path, NULL, m_actual.x, m_actual.y );
		m_actualShape.path = path;
		m_actualShape.strokeColor = [ SKColor grayColor ];
		m_actualShape.lineWidth = 2.0f;
		m_actualShape.zPosition = 2.0f;
		
		m_line1 = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, p1On.x, p1On.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line1.path = path;
		m_line1.lineWidth = 2.0f;
		m_line1.strokeColor = [ SKColor lightGrayColor ];
		m_line1.zPosition = 3.0f;
		[ self addChild: m_line1 ];
		
		m_line2 = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, p2On.x, p2On.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line2.path = path;
		m_line2.lineWidth = 2.0f;
		m_line2.strokeColor = [ SKColor lightGrayColor ];
		m_line2.zPosition = 3.0f;
		[ self addChild: m_line2 ];
		
		m_line3 = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, p3On.x, p3On.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line3.path = path;
		m_line3.lineWidth = 2.0f;
		m_line3.strokeColor = [ SKColor lightGrayColor ];
		m_line3.zPosition = 3.0f;
		[ self addChild: m_line3 ];
		
		m_cursor.position = m_actual;
		[ m_cursor setColor: [ SKColor grayColor ] ];
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
	
	path = CGPathCreateMutable();
	CGPathMoveToPoint( path, NULL, m_line3Start.x, m_line3Start.y );
	CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
	m_line3.path = path;
}

- ( void ) showActual {
	[ self addChild: m_cursor ];
	[ self addChild: m_actualShape ];
}

@end







