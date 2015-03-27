//
//  CountdownTimer.h
//  CountdownTimer
//
//  Created by Mark McGookin on 05/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountdownTimer : NSObject

- (int)getWeeks:(NSTimeInterval)timeLeft;
- (int)getDays:(NSTimeInterval)timeLeft;
- (int)getHours:(NSTimeInterval)timeLeft;
- (int)getMinutes:(NSTimeInterval)timeLeft;
- (NSString*)TimeLeftText;

@property (nonatomic) NSTimeInterval secondsPerWeek;
@property (nonatomic) NSTimeInterval secondsPerDay;
@property (nonatomic) NSTimeInterval secondsPerHour;
@property (nonatomic) NSTimeInterval secondsPerMinute;
@property (nonatomic, retain) NSDate * dtTheDate;

@end
