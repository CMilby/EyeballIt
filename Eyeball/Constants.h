//
//  Constants.h
//  Eyeball
//
//  Created by Craig Milby on 3/10/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __CONSTANTS_H__
#define __CONSTANTS_H__

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

extern NSString* const GAME_FONT;

extern CGFloat const FONT_SIZE;

extern NSString* const GD_PARALLEL_BEST;
extern NSString* const GD_PARALLEL_TOTAL;
extern NSString* const GD_MIDPOINT_BEST;
extern NSString* const GD_MIDPOINT_TOTAL;
extern NSString* const GD_BISECT_BEST;
extern NSString* const GD_BISECT_TOTAL;
extern NSString* const GD_TRIANGLE_BEST;
extern NSString* const GD_TRIANGLE_TOTAL;
extern NSString* const GD_CIRCLE_BEST;
extern NSString* const GD_CIRCLE_TOTAL;
extern NSString* const GD_RIGHT_BEST;
extern NSString* const GD_RIGHT_TOTAL;
extern NSString* const GD_CONVERGE_BEST;
extern NSString* const GD_CONVERGE_TOTAL;

extern NSString* const GD_AVG_ERROR_BEST;
extern NSString* const GD_AVG_ERROR_WORST;
extern NSString* const GD_AVG_ERROR_TOTAL;
extern NSString* const GD_TOTAL_ERROR_BEST;
extern NSString* const GD_TOTAL_ERROR_WORST;
extern NSString* const GD_TOTAL_ERROR_TOTAL;

extern NSString* const GD_TIME_FASTEST;
extern NSString* const GD_TIME_SLOWEST;
extern NSString* const GD_TIME_TOTAL;

extern NSString* const GD_GAMES_PLAYED;

#endif /* Constants_h */
