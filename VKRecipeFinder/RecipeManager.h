//
//  RecipeManager.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Recipe;

@interface RecipeManager : NSObject

+ (RecipeManager *)sharedInstance;

- (NSArray *)readRecipesFromFile:(NSString *)filePath;
- (Recipe *)pickRecommendationFromRecipes:(NSArray *)arrRecipes andAvailabilities:(NSArray *)arrAvailabilities;

@end
