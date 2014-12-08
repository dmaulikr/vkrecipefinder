//
//  Availability.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Ingredient;

@interface Availability : NSObject

@property (strong, nonatomic) NSString *item;
@property (assign, nonatomic) int amount;
@property (strong, nonatomic) NSString *unit;
@property (strong, nonatomic) NSDate *expiryDate;

- (BOOL)sufficientForIngredient:(Ingredient *)ingredient;

@end
