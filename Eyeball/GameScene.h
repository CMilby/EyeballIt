//
//  GameScene.h
//  Eyeball
//

//  Copyright (c) 2016 Craig Milby. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene {
	CGPoint m_firstTouch;
	CGPoint m_oldLoc;
}

- ( id ) initWithSize: ( CGSize ) size withBannerHeight: ( CGFloat ) bannerHeight;

@end
