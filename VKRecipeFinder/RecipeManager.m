//
//  RecipeManager.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "RecipeManager.h"
#import "Recipe.h"
#import "Ingredient.h"

#define KEY_NAME @"name"
#define KEY_INGREDIENTS @"ingredients"
#define KEY_ITEM @"item"
#define KEY_AMOUNT @"amount"
#define KEY_UNIT @"unit"

@implementation RecipeManager

+ (RecipeManager *)sharedInstance
{
	static RecipeManager *sharedInstance;

	@synchronized(self)
	{
		if (!sharedInstance)
		{
			sharedInstance = [[RecipeManager alloc] init];
		}

		return sharedInstance;
	}
}

- (NSArray *)readRecipesFromFile:(NSString *)filePath
{
	NSMutableArray *result = [NSMutableArray array];

	// Does the file exist?
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:filePath])
	{
		// Parse the file (json)
		NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
		NSError *error;
		NSArray *arrRecipes = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

		// Any error in parsing the json content?
		if (error == nil)
		{
			// Extract recipes list
			for (NSDictionary *dictRecipe in arrRecipes)
			{
				Recipe *recipe = [Recipe new];
				recipe.name = [dictRecipe objectForKey:KEY_NAME];

				// Extract ingredients list for this recipe
				NSMutableArray *arrIngredients = [NSMutableArray array];
				for (NSDictionary *dictIngredient in [dictRecipe objectForKey:KEY_INGREDIENTS])
				{
					// Create new ingredient
					Ingredient *ingredient = [Ingredient new];
					ingredient.item 	= [dictIngredient objectForKey:KEY_ITEM];
					ingredient.amount 	= [[dictIngredient objectForKey:KEY_AMOUNT] intValue];
					ingredient.unit 	= [dictIngredient objectForKey:KEY_UNIT];

					[arrIngredients addObject:ingredient];
				}

				recipe.ingredients = [NSArray arrayWithArray:arrIngredients];

				[result addObject:recipe];
			}
		}
	}

	return [NSArray arrayWithArray:result];
}

- (Recipe *)pickRecommendationFromRecipes:(NSArray *)arrRecipes andAvailabilities:(NSArray *)arrAvailabilities
{
	NSLog(@"pick now");

	return nil;
}

@end
