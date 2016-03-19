//
//  Stopwatch.m
//  Eyeball
//
//  Created by Craig Milby on 3/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "Stopwatch.h"

@implementation StopWatch {
	
}

- ( id ) init {
	if ( self = [ super init ] ) {
		m_timeString = @"0:00.0";
	}
	return self;
}

- ( void ) start {
	m_timer = [ NSTimer timerWithTimeInterval: 1.0f / 10.0f target: self selector: @selector( handleTick ) userInfo: nil repeats: true ];
	NSRunLoop *loop = [ NSRunLoop currentRunLoop ];
	[ loop addTimer: m_timer forMode: NSDefaultRunLoopMode ];
	
	m_startDate = [ [ NSDate alloc ] init ];
}

- ( void ) stop {
	m_secondsAlreadyRun += [ [ NSDate date ] timeIntervalSinceDate: m_startDate ];
	[ m_timer invalidate ];
	m_timer = nil;
}

- ( void ) handleTick {
	NSDate *currentDate = [ NSDate date ];
	NSTimeInterval timeInterval = [ currentDate timeIntervalSinceDate: m_startDate ];

	timeInterval += m_secondsAlreadyRun;
	NSDate *timerDate = [ NSDate dateWithTimeIntervalSince1970: timeInterval ];
	NSDateFormatter *dateFormatter = [ [ NSDateFormatter alloc ] init ];
	
	[ dateFormatter setDateFormat: @"m:ss.S" ];
	[ dateFormatter setTimeZone: [ NSTimeZone timeZoneForSecondsFromGMT: 0.0 ] ];
	NSArray<NSString*> *dateArray = [ [ dateFormatter stringFromDate: timerDate ] componentsSeparatedByString: @":" ];
	NSArray<NSString*> *minArray = [ [ dateArray objectAtIndex: 1 ] componentsSeparatedByString: @"." ];
	int addMins = [ [ dateArray objectAtIndex: 0 ] intValue ] * 60;
	m_timeString = [ NSString stringWithFormat: @"%i.%i", ( addMins + [ [ minArray objectAtIndex: 0 ] intValue ] ), [ [ minArray objectAtIndex: 1 ] intValue ] ];
}

- ( NSString* ) timeString {
	return m_timeString;
}

@end