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
	CGFloat s = sinf( angle );
	CGFloat c = cosf( angle );
	
	point = CGPointMake( point.x - center.x, point.y - center.y );
	
	CGFloat xNew = point.x * c - point.y * s;
	CGFloat yNew = point.x * s + point.y * c;
	
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

@end