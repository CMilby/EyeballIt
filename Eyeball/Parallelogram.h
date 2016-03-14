//
//  Parallelogram.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __PARALLELOGRAM_H__
#define __PARALLELOGRAM_H__

#import "Level.h"

/*
  Example Parallelograms
            __
   /\      |  |
  /  \     |  |
  \   \    |  |
   \   \   |__|
    \  /
     \/
	
*/

@interface Parrallogram : Level {
	CGPoint m_bottomLeft;
	CGPoint m_topRight;
	CGPoint m_topLeft;
	
	CGFloat m_line1Length;
	CGFloat m_line2Length;

	SKShapeNode *m_actualShape;
	SKShapeNode *m_actualDrawn;
	SKShapeNode *m_line1;
	SKShapeNode *m_line2;
}

- ( id ) init;

@end

#endif /* Parallelogram_h */
