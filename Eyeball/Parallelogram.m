//
//  Parallelogram.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "Parallelogram.h"

@implementation Parrallogram {
	
}

- ( id ) init: ( CGFloat ) height {
	if ( self = [ super init: height ] ) {
		CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
		CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
		
		m_line1Length = [ self randomFloatInRange: width * 0.25f max: width * 0.3f ];
		m_line2Length = m_line1Length * [ self randomFloatInRange: 1.5f max: 1.9f ];
		
		CGPoint middle = CGPointMake( width / 2, height / 2 );
		m_bottomLeft = CGPointMake( -m_line1Length / 2 + middle.x, -m_line1Length / 2 + middle.y );
		m_actual = CGPointMake( m_line2Length / 2 + middle.x, -m_line2Length / 2 + middle.y );
		m_topLeft = CGPointMake( -m_line2Length / 2 + middle.x, m_line2Length / 2 + middle.y );
		m_topRight = CGPointMake( m_line1Length / 2 + middle.x, m_line1Length / 2 + middle.y );
		
		CGFloat rotation = [ self randomFloatInRange: 0.0f max: 360.0f ];
		m_bottomLeft = [ self rotate: middle angle: rotation point: m_bottomLeft ];
		m_actual = [ self rotate: middle angle: rotation point: m_actual ];
		m_topLeft = [ self rotate: middle angle: rotation point: m_topLeft ];
		m_topRight = [ self rotate: middle angle: rotation point: m_topRight ];
		
		m_actualShape = [ [ SKShapeNode alloc ] init ];
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_bottomLeft.x, m_bottomLeft.y );
		CGPathAddLineToPoint( path, NULL, m_topLeft.x, m_topLeft.y );
		CGPathAddLineToPoint( path, NULL, m_topRight.x, m_topRight.y );
		CGPathAddLineToPoint( path, NULL, m_actual.x, m_actual.y );
		CGPathAddLineToPoint( path, NULL, m_bottomLeft.x, m_bottomLeft.y );
		m_actualShape.path = path;
		m_actualShape.lineWidth = 2.0f;
		m_actualShape.strokeColor = [ SKColor grayColor ];
		m_actualShape.zPosition = 2.0f;
		
		m_actualDrawn = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_bottomLeft.x, m_bottomLeft.y );
		CGPathAddLineToPoint( path, NULL, m_topLeft.x, m_topLeft.y );
		CGPathAddLineToPoint( path, NULL, m_topRight.x, m_topRight.y );
		m_actualDrawn.path = path;
		m_actualDrawn.lineWidth = 2.0f;
		m_actualDrawn.strokeColor = [ SKColor whiteColor ];
		m_actualDrawn.zPosition = 3.0f;
		[ self addChild: m_actualDrawn ];
		
		m_point = m_actual;
		m_point = CGPointMake( m_point.x + [ self randomIntInRange: -20 max: 20 ], m_point.y + [ self randomIntInRange: -20 max: 20 ] );
		
		m_line1 = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_topRight.x, m_topRight.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line1.path = path;
		m_line1.lineWidth = 2.0f;
		m_line1.strokeColor = [ SKColor lightGrayColor ];
		m_line1.zPosition = 3.0f;
		[ self addChild: m_line1 ];
		
		m_line2 = [ [ SKShapeNode alloc ] init ];
		path = CGPathCreateMutable();
		CGPathMoveToPoint( path, NULL, m_bottomLeft.x, m_bottomLeft.y );
		CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
		m_line2.path = path;
		m_line2.lineWidth = 2.0f;
		m_line2.strokeColor = [ SKColor lightGrayColor ];
		m_line2.zPosition = 3.0f;
		[ self addChild: m_line2 ];
		
		m_cursor.position = m_actual;
		[ m_cursor setColor: [ SKColor grayColor ] ];
		
		m_prompt.text = @"Make a parallelogram";
	}
	return self;
}

- ( void ) setPoint: ( CGPoint ) point {
	m_point = point;
	
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint( path, NULL, m_topRight.x, m_topRight.y );
	CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
	m_line1.path = path;
	
	path = CGPathCreateMutable();
	CGPathMoveToPoint( path, NULL, m_bottomLeft.x, m_bottomLeft.y );
	CGPathAddLineToPoint( path, NULL, m_point.x, m_point.y );
	m_line2.path = path;
}

- ( void ) showActual {
	[ self addChild: m_actualShape ];
	[ self addChild: m_cursor ];
	[ m_prompt removeFromParent ];
}

@end