//
//  IngredientSectionHeader.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@interface IngredientSectionHeader : UICollectionReusableView

@property (strong, nonatomic) UILabel *recipeNameLabel;

- (void)setupSubviewsWithRecipe:(Recipe *)recipe;

@end
