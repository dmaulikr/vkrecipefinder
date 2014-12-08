//
//  FridgeManager.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "FridgeManager.h"
#import "Availability.h"

#define INDEX_ITEM 0
#define INDEX_AMOUNT 1
#define INDEX_UNIT 2
#define INDEX_EXPIRY_DATE 3

@implementation FridgeManager

+ (FridgeManager *)sharedInstance
{
	static FridgeManager *sharedInstance;

	@synchronized(self)
	{
		if (!sharedInstance)
		{
			sharedInstance = [[FridgeManager alloc] init];
		}

		return sharedInstance;
	}
}

- (NSArray *)readAvailabilitesFromFile:(NSString *)filePath
{
	NSMutableArray *result = [NSMutableArray array];

	// Does the file exist?
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:filePath])
	{
		// Parse the file (csv)
		NSError *error;
		NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];

		// Any error in parsing the file content?
		if (error == nil)
		{
			// Extract availability from lines
			for (NSString *line in [fileContent componentsSeparatedByString:@"\n"])
			{
				NSArray *arrLineComponents = [line componentsSeparatedByString:@","];
				Availability *availability = [Availability new];
				availability.item 	= arrLineComponents[INDEX_ITEM];
				availability.amount = [arrLineComponents[INDEX_AMOUNT] intValue];
				availability.unit 	= arrLineComponents[INDEX_UNIT];

				// Parse the date in the format "dd/mm/yyyy" or "dd/mm/yy"
				NSArray *arrDateParts = [arrLineComponents[INDEX_EXPIRY_DATE] componentsSeparatedByString:@"/"];
				int day   = [arrDateParts[0] intValue];
				int month = [arrDateParts[1] intValue];
				int year  = [arrDateParts[2] intValue];

				// Cater for year of both '2014' & '14' formats
				if (year < 100)
				{
					year = year + 2000;
				}

				// Construct the date from each component
				NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
				[dateComponents setYear:year];
				[dateComponents setMonth:month];
				[dateComponents setDay:day];
				[dateComponents setHour:0];
				[dateComponents setMinute:0];
				[dateComponents setSecond:0];

				availability.expiryDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];

				[result addObject:availability];
			}
		}
	}

	return [NSArray arrayWithArray:result];
}

@end
