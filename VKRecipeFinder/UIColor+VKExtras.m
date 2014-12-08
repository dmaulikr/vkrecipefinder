//
//  UIColor+VKExtras.m
//  VKFramework
//
//  Created by Vinh Khoa Nguyen on 18/04/13.
//  Copyright (c) 2013 Vinh Khoa Nguyen. All rights reserved.
//

#import "UIColor+VKExtras.h"

@implementation UIColor (VKExtras)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha
{
	return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue
{
	return [self colorWithR:red G:green B:blue alpha:1];
}

+ (UIColor *)colorWithHex:(NSString *)hexValue
{
	return [self colorWithHex:hexValue alpha:1];
}

+ (UIColor *)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alpha
{
	UIColor *result;
	
	// Did user pass in the # character with 7 or 4 characters? Remove the #
	if ((hexValue.length == 7 || hexValue.length == 4) && [[hexValue substringToIndex:1] isEqualToString:@"#"])
	{
		hexValue = [hexValue substringFromIndex:1];
	}
	
	// Only 3 characters? Double it, eg. 'abc' becomes 'aabbcc'
	if (hexValue.length == 3)
	{
		NSString *str1 = [hexValue substringWithRange:NSMakeRange(0, 1)];
		NSString *str2 = [hexValue substringWithRange:NSMakeRange(1, 1)];
		NSString *str3 = [hexValue substringWithRange:NSMakeRange(2, 1)];
		
		hexValue = [NSString stringWithFormat:@"%@%@%@%@%@%@", str1, str1, str2, str2, str3, str3];
	}

	// Convert to uppercase for easy manipulation
	hexValue = hexValue.uppercaseString;

	// Not 6 characters or contains invalid characters?
	NSString *illegalCharacters = [hexValue stringByReplacingOccurrencesOfString:@"[0-9A-F]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, hexValue.length)];
	if (hexValue.length != 6 || illegalCharacters.length > 0)
	{
		result = nil;
		return result;
	}
	
	// Red
	unsigned int redValue;
	[[NSScanner scannerWithString:[hexValue substringWithRange:NSMakeRange(0, 2)]] scanHexInt:&redValue];

	// Green
	unsigned int greenValue;
	[[NSScanner scannerWithString:[hexValue substringWithRange:NSMakeRange(2, 2)]] scanHexInt:&greenValue];

	// Red
	unsigned int blueValue;
	[[NSScanner scannerWithString:[hexValue substringWithRange:NSMakeRange(4, 2)]] scanHexInt:&blueValue];
	
	return [self colorWithR:redValue G:greenValue B:blueValue alpha:alpha];
}

@end
