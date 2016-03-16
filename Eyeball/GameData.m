//
//  GameData.m
//  Eyeball
//
//  Created by Craig Milby on 3/15/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "GameData.h"

#import "Constants.h"

@implementation GameData {
	
}

+ ( id ) sharedGameData {
	static GameData *sharedInstance = nil;
 
	static dispatch_once_t onceToken;
	dispatch_once( &onceToken, ^{
		sharedInstance = [ self loadInstance ];
	});

	return sharedInstance;
}

- ( id ) initWithCoder: ( NSCoder* ) decoder {
	if ( self = [ self init ] ) {
		// Decode
		_parallelogramClosest = [ decoder decodeFloatForKey: GD_PARALLEL_BEST ];
		_parallelogramTotalError = [ decoder decodeFloatForKey: GD_PARALLEL_TOTAL ];
		_midpointCloseset = [ decoder decodeFloatForKey: GD_MIDPOINT_BEST ];
		_midpointTotalError = [ decoder decodeFloatForKey: GD_MIDPOINT_TOTAL ];
		_bisectCloseset = [ decoder decodeFloatForKey: GD_BISECT_BEST ];
		_bisectTotalError = [ decoder decodeFloatForKey: GD_BISECT_TOTAL ];
		_triangleCloseset = [ decoder decodeFloatForKey: GD_TRIANGLE_BEST ];
		_triangleTotalError = [ decoder decodeFloatForKey: GD_TRIANGLE_TOTAL ];
		_circleClosest = [ decoder decodeFloatForKey: GD_CIRCLE_BEST ];
		_circleTotalError = [ decoder decodeFloatForKey: GD_CIRCLE_TOTAL ];
		_rightCloseset = [ decoder decodeFloatForKey: GD_RIGHT_BEST ];
		_rightTotalError = [ decoder decodeFloatForKey: GD_RIGHT_TOTAL ];
		_convergenceCloseset = [ decoder decodeFloatForKey: GD_CONVERGE_BEST ];
		_convergenceTotalError = [ decoder decodeFloatForKey: GD_CONVERGE_TOTAL ];
		
		_avgErrorBest = [ decoder decodeFloatForKey: GD_AVG_ERROR_BEST ];
		_avgErrorWorst = [ decoder decodeFloatForKey: GD_AVG_ERROR_WORST ];
		_avgErrorTotal = [ decoder decodeFloatForKey: GD_AVG_ERROR_TOTAL ];
		_totalErrorBest = [ decoder decodeFloatForKey: GD_TOTAL_ERROR_BEST ];
		_totalErrorWorst = [ decoder decodeFloatForKey: GD_TOTAL_ERROR_WORST ];
		_totalErrorTotal = [ decoder decodeFloatForKey: GD_TOTAL_ERROR_TOTAL ];
		
		_timeFastest = [ decoder decodeFloatForKey: GD_TIME_FASTEST ];
		_timeSlowest = [ decoder decodeFloatForKey: GD_TIME_SLOWEST ];
		_timeTotal = [ decoder decodeFloatForKey: GD_TIME_TOTAL ];
		
		_gamesPlayed = [ decoder decodeInt32ForKey: GD_GAMES_PLAYED ];
	}
	return self;
}

- ( void ) reset {
	_parallelogramClosest = _midpointCloseset = _bisectCloseset = _triangleCloseset = _circleClosest = _rightCloseset = _convergenceCloseset = 100000000.0f;
	_parallelogramTotalError = _midpointTotalError = _bisectTotalError = _triangleTotalError = _circleTotalError = _rightTotalError = _convergenceTotalError = 0.0f;
	
	_avgErrorBest = 10000000.0f;
	_avgErrorWorst = -1.0f;
	_avgErrorTotal = 0.0f;
	_totalErrorBest = 10000000.0f;
	_totalErrorWorst = -1.0f;
	_totalErrorTotal = 0.0f;
	
	_timeFastest = 100000000.0f;
	_timeSlowest = -1.0f;
	_timeTotal = 0.0f;
	
	_gamesPlayed = 0;
}

- ( void ) save {
	NSData *encodedData = [ NSKeyedArchiver archivedDataWithRootObject: self ];
	[ encodedData writeToFile: [ GameData filePath ] atomically: YES ];
}

- ( void ) encodeWithCoder: ( NSCoder* ) coder {
	[ coder encodeFloat: self.parallelogramClosest forKey: GD_PARALLEL_BEST ];
	[ coder encodeFloat: self.parallelogramTotalError forKey: GD_PARALLEL_TOTAL ];
	[ coder encodeFloat: self.midpointCloseset forKey: GD_MIDPOINT_BEST ];
	[ coder encodeFloat: self.midpointTotalError forKey: GD_MIDPOINT_TOTAL ];
	[ coder encodeFloat: self.bisectCloseset forKey: GD_BISECT_BEST ];
	[ coder encodeFloat: self.bisectTotalError forKey: GD_BISECT_TOTAL ];
	[ coder encodeFloat: self.triangleCloseset forKey: GD_TRIANGLE_BEST ];
	[ coder encodeFloat: self.triangleTotalError forKey: GD_TRIANGLE_TOTAL ];
	[ coder encodeFloat: self.circleClosest forKey: GD_CIRCLE_BEST ];
	[ coder encodeFloat: self.circleTotalError forKey: GD_CIRCLE_TOTAL ];
	[ coder encodeFloat: self.rightCloseset forKey: GD_RIGHT_BEST ];
	[ coder encodeFloat: self.rightTotalError forKey: GD_RIGHT_TOTAL ];
	[ coder encodeFloat: self.convergenceCloseset forKey: GD_CONVERGE_BEST ];
	[ coder encodeFloat: self.convergenceTotalError forKey: GD_CONVERGE_TOTAL ];
	
	[ coder encodeFloat: self.avgErrorBest forKey: GD_AVG_ERROR_BEST ];
	[ coder encodeFloat: self.avgErrorWorst forKey: GD_AVG_ERROR_WORST ];
	[ coder encodeFloat: self.avgErrorTotal forKey: GD_AVG_ERROR_TOTAL ];
	[ coder encodeFloat: self.totalErrorBest forKey: GD_TOTAL_ERROR_BEST ];
	[ coder encodeFloat: self.totalErrorWorst forKey: GD_TOTAL_ERROR_WORST ];
	[ coder encodeFloat: self.totalErrorTotal forKey: GD_TOTAL_ERROR_TOTAL ];
	
	[ coder encodeFloat: self.timeFastest forKey: GD_TIME_FASTEST ];
	[ coder encodeFloat: self.timeSlowest forKey: GD_TIME_SLOWEST ];
	[ coder encodeFloat: self.timeTotal forKey: GD_TIME_TOTAL ];
	
	[ coder encodeInt32: self.gamesPlayed forKey: GD_GAMES_PLAYED ];
}

+ ( NSString* ) filePath {
	static NSString *path = nil;
	if ( !path ) {
		path = [ [ NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES ) firstObject ] stringByAppendingPathComponent: @"gamedata" ];
	}
	return path;
}

+ ( instancetype ) loadInstance {
	NSData *decodedData = [ NSData dataWithContentsOfFile: [ GameData filePath ] ];
	if ( decodedData ) {
		GameData *gameData = [ NSKeyedUnarchiver unarchiveObjectWithData: decodedData ];
		return gameData;
	}
	GameData *data = [ [ GameData alloc ] init ];
	[ data reset ];
	[ data save ];
	return data;
}

@end







