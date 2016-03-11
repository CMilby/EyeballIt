//
//  Cursor.h
//  Eyeball
//
//  Created by Craig Milby on 3/11/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __CURSOR_H__
#define __CURSOR_H__

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Cursor : SKNode {
	SKShapeNode *m_cursorFrame;
	SKShapeNode *m_crosshair;
}

- ( id ) init;

- ( void ) setColor: ( UIColor* ) color;

@end

#endif /* Cursor_h */
