//
//  HowToPlayScene.h
//  Eyeball
//
//  Created by Craig Milby on 3/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __HOW_TO_PLAY_SCENE_H__
#define __HOW_TO_PLAY_SCENE_H__

#import "Constants.h"
#import "MainMenuScene.h"

@interface HowToPlayScene : SKScene {
	MainMenuScene *m_mainMenu;
}

- ( id ) initWithSize: ( CGSize ) size mainMenu: ( MainMenuScene* ) scene;

@end

#endif /* HowToPlayScene_h */
