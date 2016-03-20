//
//  MainMenuScene.h
//  Eyeball
//
//  Created by Craig Milby on 3/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __MAIN_MENU_SCENE_H__
#define __MAIN_MENU_SCENE_H__

#import "Constants.h"
#import "GameViewController.h"

@interface MainMenuScene : SKScene {
	
}

- ( id ) initWithSize: ( CGSize ) size withBannerHeight: ( CGFloat ) bannerHeight withGameView: ( GameViewController* ) viewController;

@end

#endif /* MainMenuScene_h */
