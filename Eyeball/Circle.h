//
//  Circle.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __CIRCLE_H__
#define __CIRCLE_H__

#import "Level.h"

@interface Circle : Level {
	CGRect m_circleFrame;
	
	SKShapeNode *m_shape;
}

- ( id ) init;

@end

#endif /* Circle_h */
