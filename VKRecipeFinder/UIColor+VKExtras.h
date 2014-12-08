//
//  UIColor+VKExtras.h
//  VKFramework
//
//  Created by Vinh Khoa Nguyen on 18/04/13.
//  Copyright (c) 2013 Vinh Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (VKExtras)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;
+ (UIColor *)colorWithHex:(NSString *)hexValue;
+ (UIColor *)colorWithHex:(NSString *)hexValue alpha:(CGFloat)alpha;

@end
