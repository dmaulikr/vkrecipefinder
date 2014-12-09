//
//  IngredientSectionHeader.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "IngredientSectionHeader.h"
#import "Constants.h"
#import "UIView+VKExtras.h"
#import "UIColor+VKExtras.h"
#import "Recipe.h"

@implementation IngredientSectionHeader

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		self.recipeNameLabel = [UILabel new];
		self.recipeNameLabel.font = [UIFont boldSystemFontOfSize:APP_FONT_SIZE * 1.3];
		self.recipeNameLabel.textColor = APP_TEXT_COLOR;
		self.recipeNameLabel.textAlignment = NSTextAlignmentCenter;
		self.recipeNameLabel.numberOfLines = 0;
		self.recipeNameLabel.adjustsFontSizeToFitWidth = YES;
		self.recipeNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:self.recipeNameLabel];
		[self.recipeNameLabel constraintToSuperViewCover];
	}

	return self;
}

- (void)setupSubviewsWithRecipe:(Recipe *)recipe
{
	self.recipeNameLabel.text = recipe.name;
}

@end
