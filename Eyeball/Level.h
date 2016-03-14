//
//  Level.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __LEVEL_H__
#define __LEVEL_H__

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Constants.h"
#import "Cursor.h"

@interface Level : SKNode {
	CGPoint m_point;
	CGPoint m_actual;
	
	SKLabelNode *m_prompt;
	Cursor *m_cursor;
}

- ( id ) init: ( CGFloat ) offset;

- ( CGPoint ) point;

- ( void ) setPoint: ( CGPoint ) point;

- ( CGFloat ) errorMargin;

- ( void ) showActual;

- ( NSInteger ) randomIntInRange: ( NSInteger ) min max: ( NSInteger ) max;

- ( CGFloat ) randomFloatInRange: ( CGFloat ) min max: ( CGFloat ) max;

- ( CGFloat ) distance: ( CGPoint ) p1 p2: ( CGPoint ) p2;

- ( CGPoint ) rotate: ( CGPoint ) center angle: ( CGFloat ) angle point: ( CGPoint ) point;

- ( CGPoint ) midpoint: ( CGPoint ) p1 p2: ( CGPoint ) p2;

- ( CGFloat ) angleOf: ( CGPoint ) p1 p2: ( CGPoint ) p2;

- ( CGPoint ) linesIntersect: ( CGPoint ) p1 p2: ( CGPoint ) p2 p3: ( CGPoint ) p3 p4: ( CGPoint ) p4;

- ( CGFloat ) angle: ( CGPoint ) p1 p2: ( CGPoint ) p2 p3: ( CGPoint ) p3;

@end

#endif /* Level_h */
