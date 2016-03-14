//
//  Stopwatch.h
//  Eyeball
//
//  Created by Craig Milby on 3/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __STOPWATCH_H__
#define __STOPWATCH_H__

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface StopWatch : NSObject {
	NSTimer *m_timer;
	NSDate *m_startDate;
}

- ( id ) init;

- ( void ) start;

- ( void ) stop;

- ( void ) pause;

@end

#endif /* Stopwatch_h */
