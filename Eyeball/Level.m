//
//  Level.m
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "Level.h"

@implementation Level {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		m_cursor = [ [ Cursor alloc ] init ];
		
		m_prompt = [ SKLabelNode labelNodeWithFontNamed: GAME_FONT ];
		m_prompt.text = @"Add your text here!";
		m_prompt.fontSize = FONT_SIZE * [ UIScreen mainScreen ].bounds.size.height;
		m_prompt.color = [ SKColor whiteColor ];
		m_prompt.position = CGPointMake( [ UIScreen mainScreen ].bounds.size.width / 2, [ UIScreen mainScreen ].bounds.size.height - ( ( [ UIScreen mainScreen ].bounds.size.height * FONT_SIZE ) * 1.5f ) );
		[ self addChild: m_prompt ];
	}
	return self;
}

- ( CGPoint ) point {
	return m_point;
}

- ( void ) setPoint: ( CGPoint ) point {
	m_point = point;
}

- ( CGFloat ) errorMargin {
	return [ self distance: m_point p2: m_actual ];
}

- ( void ) showActual {
	
}

- ( NSInteger ) randomIntInRange: ( NSInteger ) min max: ( NSInteger ) max {
	return ( NSInteger ) ( min + ( int ) arc4random_uniform( ( int ) ( max - min + 1 ) ) );
}

- ( CGFloat ) randomFloatInRange: ( CGFloat ) min max: ( CGFloat ) max {
	return min + arc4random_uniform( max - min + 1 );
}

- ( CGFloat ) distance: ( CGPoint ) p1 p2: ( CGPoint ) p2 {
	return sqrtf( powf( p2.x - p1.x, 2.0f ) + powf( p2.y - p1.y, 2.0f ) );
}

- ( CGPoint ) rotate: ( CGPoint ) center angle: ( CGFloat ) angle point: ( CGPoint ) point {
	CGFloat s = ( sinf( angle * ( M_PI / 180.0f ) ) );
	CGFloat c = ( cosf( angle * ( M_PI / 180.0f ) ) );
	
	CGPoint newPoint = CGPointMake( point.x - center.x, point.y - center.y );
	
	CGFloat xNew = newPoint.x * c - newPoint.y * s;
	CGFloat yNew = newPoint.x * s + newPoint.y * c;
	
	return CGPointMake( xNew + center.x, yNew + center.y );
}

- ( CGPoint ) midpoint: ( CGPoint ) p1 p2: ( CGPoint ) p2 {
	return CGPointMake( ( p1.x + p2.x ) / 2.0f, ( p1.y + p2.y ) / 2.0f );
}

- ( CGFloat ) angleOf: ( CGPoint ) p1 p2: ( CGPoint ) p2 {
	CGFloat deltaY = p1.y - p2.y;
	CGFloat deltaX = p2.x - p1.x;
	CGFloat result = atan2f( deltaY, deltaX ) * ( 180.0f / M_PI );
	return ( result < 0.0f ) ? ( 360.0f + result ) : result;
}

- ( CGPoint ) linesIntersect: ( CGPoint ) p1 p2: ( CGPoint ) p2 p3: ( CGPoint ) p3 p4: ( CGPoint ) p4 {
	CGFloat d = ( p2.x - p1.x ) * ( p4.y - p3.y ) - ( p2.y - p1.y ) * ( p4.x - p3.x );
	if ( d == 0 ) {
		return CGPointMake( -1.0f, -1.0f );
	}
	
	CGFloat u = ( ( p3.x - p1.x ) * ( p4.y - p3.y ) - ( p3.y - p1.y ) * ( p4.x - p3.x ) ) / d;
	CGFloat v = ( ( p3.x - p1.x ) * ( p2.y - p1.y ) - ( p3.y - p1.y ) * ( p2.x - p1.x ) ) /d;
	if (u < 0.0 || u > 1.0)
		return CGPointMake( -1.0f, -1.0f );
	if (v < 0.0 || v > 1.0)
		return CGPointMake( -1.0f, -1.0f );
	CGPoint intersection;
	intersection.x = p1.x + u * ( p2.x - p1.x );
	intersection.y = p1.y + u * ( p2.y - p1.y );
	
	return intersection;
}

- ( CGFloat ) angle: ( CGPoint ) p1 p2: ( CGPoint ) p2 p3: ( CGPoint ) p3 {
	CGFloat p12 = [ self distance: p1 p2: p2 ];
	CGFloat p13 = [ self distance: p1 p2: p3 ];
	CGFloat p23 = [ self distance: p3 p2: p2 ];
	
	CGFloat a = powf( p12, 2.0f ) + powf( p13, 2.0f ) + powf( p23, 2.0f );
	CGFloat b = 2 * p12 * p13;
	CGFloat c = a / b;
	CGFloat d = acos( c * ( M_PI / 180.0f ) );
	return d * ( 180.0f / M_PI );
}

@end