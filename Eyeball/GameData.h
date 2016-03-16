//
//  GameData.h
//  Eyeball
//
//  Created by Craig Milby on 3/15/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __GAME_DATA_H__
#define __GAME_DATA_H__

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface GameData : NSObject<NSCoding> {
	
}

@property( assign, nonatomic ) float parallelogramClosest;
@property( assign, nonatomic ) float midpointCloseset;
@property( assign, nonatomic ) float bisectCloseset;
@property( assign, nonatomic ) float triangleCloseset;
@property( assign, nonatomic ) float circleClosest;
@property( assign, nonatomic ) float rightCloseset;
@property( assign, nonatomic ) float convergenceCloseset;

@property( assign, nonatomic ) float parallelogramTotalError;
@property( assign, nonatomic ) float midpointTotalError;
@property( assign, nonatomic ) float bisectTotalError;
@property( assign, nonatomic ) float triangleTotalError;
@property( assign, nonatomic ) float circleTotalError;
@property( assign, nonatomic ) float rightTotalError;
@property( assign, nonatomic ) float convergenceTotalError;

@property( assign, nonatomic ) float avgErrorBest;
@property( assign, nonatomic ) float totalErrorBest;
@property( assign, nonatomic ) float avgErrorWorst;
@property( assign, nonatomic ) float totalErrorWorst;

@property( assign, nonatomic ) float avgErrorTotal;
@property( assign, nonatomic ) float totalErrorTotal;

@property( assign, nonatomic ) float timeFastest;
@property( assign, nonatomic ) float timeSlowest;

@property( assign, nonatomic ) float timeTotal;

@property( assign, nonatomic ) int gamesPlayed;

+ ( instancetype ) sharedGameData;

- ( void ) reset;

- ( void ) save;

@end

#endif /* GameData_h */
