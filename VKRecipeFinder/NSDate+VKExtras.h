//
//  NSDate+VKExtras.h
//  VKFramework
//
//  Created by Vinh Khoa Nguyen on 24/04/13.
//  Copyright (c) 2013 Vinh Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (VKExtras)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)startOfTheDate:(NSDate *)date;

@end
