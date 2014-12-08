//
//  Ingredient.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

- (NSString *)description
{
	return [NSString stringWithFormat:@"Ingredient: %@, %d %@", self.item, self.amount, self.unit];
}

@end
