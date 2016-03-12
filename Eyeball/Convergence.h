
//
//  Convergence.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __CONVERGENCE_H__
#define __CONVERGENCE_H__

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Level.h"

@interface Convergence : Level {
	SKShapeNode *m_shape;
	SKShapeNode *m_actualShape;
	
	SKShapeNode *m_line1;
	SKShapeNode *m_line2;
	SKShapeNode *m_line3;
	
	CGPoint m_base;
}

- ( id ) init;

@end


#endif /* Convergence_h */
