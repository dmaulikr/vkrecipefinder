//
//  Recipe.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

- (NSString *)description
{
	return [NSString stringWithFormat:@"Recipe: %@, %lu ingredients", self.name, (unsigned long)self.ingredients.count];
}

@end
