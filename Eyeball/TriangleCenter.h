//
//  TriangleCenter.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __TRIANGLE_CENTER_H__
#define __TRIANGLE_CENTER_H__

#import "Level.h"

@interface TriangleCenter : Level {
	SKShapeNode *m_shape;
	
	CGPoint m_p1;
	CGPoint m_p2;
	CGPoint m_p3;
}

- ( id ) init: ( CGFloat ) height;

@end

#endif /* TriangleCenter_h */
