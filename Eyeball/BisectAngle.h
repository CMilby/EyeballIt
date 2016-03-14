//
//  BisectAngle.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __BISECT_ANGLE_H__
#define __BISECT_ANGLE_H__

#import "Level.h"

@interface BisectAngle : Level {
	SKShapeNode *m_shape;
	
	CGPoint m_base;
	CGPoint m_l1;
	CGPoint m_l2;
	CGFloat m_angle;
	
	SKShapeNode *m_line;
	SKShapeNode *m_actualLine;
}

- ( id ) init;

@end

#endif /* BisectAngle_h */
