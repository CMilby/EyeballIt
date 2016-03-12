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
	}
	return self;
}

@end