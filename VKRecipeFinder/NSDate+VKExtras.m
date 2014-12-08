//
//  NSDate+VKExtras.m
//  VKFramework
//
//  Created by Vinh Khoa Nguyen on 24/04/13.
//  Copyright (c) 2013 Vinh Khoa Nguyen. All rights reserved.
//

#import "NSDate+VKExtras.h"

@implementation NSDate (VKExtras)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
	// Set up components
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setYear:year];
	[components setMonth:month];
	[components setDay:day];
	[components setHour:hour];
	[components setMinute:minute];
	[components setSecond:second];
	
	return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSDate *)startOfTheDate:(NSDate *)date
{
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
	return [self dateWithYear:components.year month:components.month day:components.day hour:0 minute:0 second:0];
}

@end
