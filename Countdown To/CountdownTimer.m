//
//  CountdownTimer.m
//  CountdownTimer
//
//  Created by Mark McGookin on 05/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CountdownTimer.h"

@implementation CountdownTimer
@synthesize secondsPerDay, secondsPerHour, secondsPerWeek, secondsPerMinute, dtTheDate;

-(id)init
{
    secondsPerWeek = 7 * 24 * 60 * 60;
    secondsPerDay = 24 * 60 * 60;
    secondsPerHour = 60 * 60;
    secondsPerMinute = 60;
    return self;
}

- (NSString*)TimeLeftText
{
	NSTimeInterval temp = [dtTheDate timeIntervalSinceNow];
	
	int wholeWeeks = [self getWeeks:temp];
	temp = temp - (wholeWeeks * secondsPerWeek);
	
	int wholeDays = [self getDays:temp];
	temp = temp - (wholeDays * secondsPerDay);
	
	int wholeHours = [self getHours:temp];
	temp = temp - (wholeHours * secondsPerHour);
	
	int wholeMinutes = [self getMinutes:temp];
	temp = temp - (wholeMinutes * secondsPerMinute);
	
	NSString *labelText = [NSString stringWithFormat:@"%02d : %02d : %02d : %02d : %02d", wholeWeeks, wholeDays, wholeHours, wholeMinutes, (int)temp];
    
    return labelText;
}

- (int)getWeeks:(NSTimeInterval)timeLeft
{
	int weeks = 0;
	while (timeLeft > 0) 
	{
		if((timeLeft - secondsPerWeek) > 0)
		{
			weeks = weeks + 1;
		}
		
		timeLeft = timeLeft - secondsPerWeek;
		
	}
	return weeks;
}

- (int)getDays:(NSTimeInterval)timeLeft
{
	int days = 0;
	while (timeLeft > 0) 
	{
		if((timeLeft - secondsPerDay) > 0)
		{
			days = days + 1;
		}
		timeLeft = timeLeft - secondsPerDay;
	}
	return days;
}

- (int)getMinutes:(NSTimeInterval)timeLeft
{
	int minutes = 0;
	while (timeLeft > 0) 
	{
		if((timeLeft - secondsPerMinute) > 0)
		{
			minutes = minutes + 1;
		}
		timeLeft = timeLeft - secondsPerMinute;
	}
	return minutes;
}

- (int)getHours:(NSTimeInterval)timeLeft
{
	int hours = 0;
	while (timeLeft > 0) 
	{
		if((timeLeft - secondsPerHour) > 0)
		{
			hours = hours + 1;
		}
		timeLeft = timeLeft - secondsPerHour;
	}
	return hours;
}@end
