//
//  Circle.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Circle.h"

@implementation Circle {
	
}

- ( id ) init: ( CGFloat ) height {
	if ( self = [ super init: height ] ) {
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		CGFloat halfWidth = width / 2;
		
		CGFloat xCenter = [ self randomFloatInRange: width * 0.4f max: width * 0.6f ];
		CGFloat yCenter = [ self randomFloatInRange: height * 0.4f max: height * 0.6f ];
		
		m_actual = CGPointMake( xCenter, yCenter );
		m_point = CGPointMake( m_actual.x + [ self randomIntInRange: -30 max: 30 ], m_actual.y + [ self randomIntInRange: -30 max: 30 ] );
		
		CGFloat radius;
		if ( xCenter > halfWidth ) {
			radius = [ self randomFloatInRange: width * 0.25f max: width * 0.35f ];
		} else {
			radius = [ self randomFloatInRange:	width * 0.25f max: width * 0.35f ];
		}
		
		m_circleFrame = CGRectMake( xCenter - radius, yCenter - radius, radius * 2, radius * 2 );
		m_shape = [ [ SKShapeNode alloc ] init ];
		m_shape.path = [ UIBezierPath bezierPathWithOvalInRect: m_circleFrame ].CGPath;
		m_shape.lineWidth = 2.0f;
		m_shape.strokeColor = [ SKColor whiteColor ];
		[ self addChild: m_shape ];
		
		m_cursor.position = m_actual;
		[ m_cursor setColor: [ SKColor grayColor ] ];
		
		m_prompt.text = @"Find the circles center";
	}
	return self;
}

- ( void ) showActual {
	[ self addChild: m_cursor ];
	[ m_prompt removeFromParent ];
}

@end