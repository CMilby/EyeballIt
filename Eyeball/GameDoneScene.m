//
//  GameDoneScene.m
//  Eyeball
//
//  Created by Craig Milby on 3/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "GameDoneScene.h"

@implementation GameDoneScene {
	
}

- ( id ) initWithSize: ( CGSize ) size withTime: ( NSString* ) time withError: ( CGFloat ) error {
	if ( self = [ super initWithSize: size ] ) {
		
	}
	return self;
}

- ( void ) didMoveToView: ( SKView* ) view {
	UITapGestureRecognizer *tapGesture = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
	[ view addGestureRecognizer: tapGesture ];
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
	
}

@end