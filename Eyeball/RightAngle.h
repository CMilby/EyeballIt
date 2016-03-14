//
//  RightAngle.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __RIGHT_ANGLE_H__
#define __RIGHT_ANGLE_H__

#import "Level.h"

@interface RightAngle : Level {
	CGPoint m_base;
	CGPoint m_angle;
	
	SKShapeNode *m_shape;
	SKShapeNode *m_line;
	SKShapeNode *m_actualShape;
}

- ( id ) init;

@end

#endif /* RightAngle_h */
