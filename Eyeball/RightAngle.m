//
//  RightAngle.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "RightAngle.h"

@implementation RightAngle {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		m_base = CGPointMake( [ self randomFloatInRange: width * 0.4f max: width * 0.6f ], [ self randomFloatInRange: height * 0.4f max: height * 0.6f ] );
		
		CGFloat angle = [ self randomFloatInRange: 0.0f max:359.0f ];
		CGFloat offset = width * 0.3f;
		m_angle = [ self rotate: m_base angle: angle point: CGPointMake( m_base.x, m_base.y + offset ) ];
		m_actual = [ self rotate: m_base angle: angle + 90.0f point: CGPointMake( m_base.x, m_base.y + offset ) ];
		m_point = CGPointMake( m_actual.x + [ self randomIntInRange: -30 max: 30 ], m_actual.y + [ self randomIntInRange: -30 max: 30 ] );
		
		m_shape = [ [ SKShapeNode alloc ] init ];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_angle.x, m_angle.y );
		CGPathAddLineToPoint( path, NULL, m_base.x, m_base.y );
		m_shape.path = path;
		m_shape.lineWidth = 2.0f;
		m_shape.strokeColor = [ SKColor whiteColor ];
		m_shape.zPosition = 3.0f;
		[ self addChild: m_shape ];
		
		m_line = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_base.x, m_base.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line.path = path;
		m_line.lineWidth = 2.0f;
		m_line.strokeColor = [ SKColor lightGrayColor ];
		m_line.zPosition = 3.0f;
		[ self addChild: m_line ];
		
		m_actualShape = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_base.x, m_base.y );
		CGPathAddLineToPoint( path, NULL, m_actual.x, m_actual.y );
		m_actualShape.path = path;
		m_actualShape.lineWidth = 2.0f;
		m_actualShape.strokeColor = [ SKColor grayColor ];
		m_actualShape.zPosition = 2.0f;
		
		m_prompt.text = @"Make a right angle";
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
	[ self addChild: m_actualShape ];
	[ m_prompt removeFromParent ];
}

- ( CGFloat ) errorMargin {
	return fabs( [ self angleOf: m_point p2: m_base ] - [ self angleOf: m_actual p2: m_base ] );
}

@end