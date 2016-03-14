//
//  BisectAngle.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "BisectAngle.h"

@implementation BisectAngle {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		CGFloat minAngle = [ self randomFloatInRange: 0.0f max: 150.0f ];
		CGFloat maxAngle = [ self randomFloatInRange: minAngle + 30 max: 320.0f ];
		
		m_base = CGPointMake( width / 2, height / 2 );
		
		CGFloat offset = width * 0.35f;
		
		m_l1 = [ self rotate: m_base angle: minAngle point: CGPointMake( m_base.x, m_base.y + offset ) ];
		m_l2 = [ self rotate: m_base angle: maxAngle point: CGPointMake( m_base.x, m_base.y + offset ) ];
		
		m_angle = ( maxAngle - minAngle ) / 2.0f;
		m_angle += minAngle;
		
		if ( maxAngle - minAngle > 180.0f ) {
			m_angle = m_angle - 180;
		}
		
		m_actual = [ self rotate: m_base angle: m_angle point: CGPointMake( m_base.x, m_base.y + offset ) ];
		m_point = CGPointMake( m_actual.x + [ self randomIntInRange: -50 max: 50 ], m_actual.y + [ self randomIntInRange: -50 max: 50 ] );
		
		m_shape = [ [ SKShapeNode alloc ] init ];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_l1.x, m_l1.y );
		CGPathAddLineToPoint( path, NULL, m_base.x, m_base.y );
		CGPathAddLineToPoint( path, NULL, m_l2.x, m_l2.y );
		m_shape.path = path;
		m_shape.lineWidth = 2.0f;
		m_shape.strokeColor = [ SKColor whiteColor ];
		[ self addChild: m_shape ];
		
		m_line = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_base.x, m_base.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line.path = path;
		m_line.lineWidth = 2.0f;
		m_line.strokeColor = [ SKColor lightGrayColor ];
		[ self addChild: m_line ];
		
		m_actualLine = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_base.x, m_base.y );
		CGPathAddLineToPoint( path, NULL, m_actual.x, m_actual.y );
		m_actualLine.path = path;
		m_actualLine.lineWidth = 2.0f;
		m_actualLine.strokeColor = [ SKColor grayColor ];
		
		m_prompt.text = @"Bisect the angle";
	}
	return self;
}

- ( void ) setPoint: ( CGPoint ) point {
	m_point = point;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint( path, NULL, m_base.x, m_base.y );
	CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
	m_line.path = path;
}

- ( void ) showActual {
	[ self addChild: m_actualLine ];
	[ m_prompt removeFromParent ];
}

- ( CGFloat ) errorMargin {
	return fabs( [ self angleOf: m_point p2: m_base ] - [ self angleOf: m_actual p2: m_base ] );
}

@end




