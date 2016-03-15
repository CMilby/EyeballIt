//
//  GameDoneScene.h
//  Eyeball
//
//  Created by Craig Milby on 3/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __GAME_DONE_SCENE_H__
#define __GAME_DONE_SCENE_H__

#import "Constants.h"

@interface GameDoneScene : SKScene {
	
}

- ( id ) initWithSize: ( CGSize ) size withTime: ( NSString* ) time withTotalError: ( CGFloat ) totalError withErrors: ( NSMutableArray<NSNumber*>* ) errors bannerHeight: ( CGFloat ) bannerHeight;

@end

#endif /* GameDoneScene_h */
