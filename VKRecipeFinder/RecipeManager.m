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
#import "Availability.h"

#define KEY_NAME @"name"
#define KEY_INGREDIENTS @"ingredients"
#define KEY_ITEM @"item"
#define KEY_AMOUNT @"amount"
#define KEY_UNIT @"unit"
#define KEY_RECIPE @"recipe"
#define KEY_EXPIRY_DATE @"expiryDate"

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
	Recipe *result = nil;
	NSMutableArray *arrPotentialRecipes = [NSMutableArray array];

	// Loop through the list of recipes to find ones that can be potentially completed
	for (Recipe *recipe in arrRecipes)
	{
		BOOL potentialRecipe = YES;
		NSDate *recipeExpiryDate;

		// Check if all ingredients are available
		for (Ingredient *ingredient in recipe.ingredients)
		{
			BOOL sufficientIngredient = NO;
			NSDate *ingredientExpiryDate;

			// Check if any availability is sufficient for this ingredient
			for (Availability *availability in arrAvailabilities)
			{
				if ([availability sufficientForIngredient:ingredient])
				{
					sufficientIngredient = YES;
					ingredientExpiryDate = availability.expiryDate;
					break;
				}
			}

			// Sufficient ingredient? Save the earliest expiry date. Otherwise discard this recipe
			if (sufficientIngredient)
			{
				if (recipeExpiryDate == nil || [recipeExpiryDate compare:ingredientExpiryDate] == NSOrderedDescending)
				{
					recipeExpiryDate = ingredientExpiryDate;
				}
			}
			else
			{
				potentialRecipe = NO;
				break;
			}
		}

		// Potential recipe? Save it
		if (potentialRecipe)
		{
			[arrPotentialRecipes addObject:@{
				KEY_RECIPE: recipe,
				KEY_EXPIRY_DATE: recipeExpiryDate
			}];
		}
	}

	NSLog(@"Potential Recipes: %@", arrPotentialRecipes);

	// Pick the potential recipe with earliest expiry date
	NSDate *earliestExpiryDate = nil;
	for (NSDictionary *dict in arrPotentialRecipes)
	{
		NSDate *thisExpiryDate = [dict objectForKey:KEY_EXPIRY_DATE];
		if (earliestExpiryDate == nil || [earliestExpiryDate compare:thisExpiryDate] == NSOrderedDescending)
		{
			earliestExpiryDate = thisExpiryDate;
			result = [dict objectForKey:KEY_RECIPE];
		}
	}

	NSLog(@"%@ at %@", result, earliestExpiryDate);

	return result;
}

@end
