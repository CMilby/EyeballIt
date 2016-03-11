//
//  LineMidpoint.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __LINE_MIDPOINT_H__
#define __LINE_MIDPOINT_H__

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Level.h"

@interface LineMidpoint : Level {
	SKShapeNode *m_line1;
	SKShapeNode *m_line2;
	SKShapeNode *m_actualLine;
	
	CGPoint m_line1Start;
	CGPoint m_line2Start;
}

- ( id ) init;

@end

#endif /* LineMidpoint_h */
