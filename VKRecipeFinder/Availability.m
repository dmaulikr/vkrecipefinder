//
//  Availability.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "Availability.h"
#import "Ingredient.h"

@implementation Availability

- (NSString *)description
{
	return [NSString stringWithFormat:@"Availability: %@, %d %@, %@", self.item, self.amount, self.unit, self.expiryDate];
}

- (BOOL)sufficientForIngredient:(Ingredient *)ingredient
{
	return 	[self.item isEqualToString:ingredient.item] &&
			[self.unit isEqualToString:ingredient.unit] &&
			self.amount >= ingredient.amount;
}

@end
