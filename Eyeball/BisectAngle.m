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
		
		m_l1 = CGPointMake( [ self randomFloatInRange: width * 0.4f max: width * 0.6f ], [ self randomFloatInRange: height * 0.35f max: height * 0.45f ] );
		m_l2 = CGPointMake( [ self randomFloatInRange: width * 0.4f max: width * 0.6f ], [ self randomFloatInRange: height * 0.55f max: height * 0.65f ] );
		m_base = [ self midpoint: m_l1 p2: m_l2 ];
		
		CGFloat l1d = [ self distance: m_base p2: m_l1 ];
		CGFloat l2d = [ self distance: m_base p2: m_l2 ];
		NSLog( @"%f, %f", l1d, l2d );
		
		m_angle = [ self angleOf: m_l1 p2: m_l2 ];
		CGFloat offset = 1;
		NSLog( @"%f", m_angle );
		
		CGFloat angle = m_angle + 90.0f;
		if ( angle >= 360.0f ) {
			angle = angle - 360.0f;
		}
		
		CGFloat c = cosf( ( angle + 90.0f ) * ( M_PI / 180.0f ) );
		CGFloat s = sinf( ( angle + 90.0f ) * ( M_PI / 180.0f ) );
		c = c * ( 180.0f / M_PI );
		s = s * ( 180.0f / M_PI );
		
		m_base = CGPointMake( m_base.x + c * offset, m_base.y + s * offset );
		m_point = CGPointMake( m_base.x + [ self randomIntInRange: -20 max: 20 ], m_base.y + [ self randomIntInRange: -20 max: 20 ] );
		
		l1d = [ self distance: m_base p2: m_l1 ];
		l2d = [ self distance: m_base p2: m_l2 ];
		NSLog( @"%f, %f", l1d, l2d );
		
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
		m_line.strokeColor = [ SKColor whiteColor ];
		[ self addChild: m_line ];
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

@end




