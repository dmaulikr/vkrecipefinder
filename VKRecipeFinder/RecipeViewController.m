//
//  RecipeViewController.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "RecipeViewController.h"
#import "Constants.h"
#import "UIView+VKExtras.h"
#import "UIColor+VKExtras.h"
#import "UIViewController+Extras.h"
#import "IngredientCollectionViewCell.h"
#import "IngredientSectionHeader.h"
#import "Recipe.h"

#define CELL_ID_INGREDIENT @"IngredientCellID"

#define CELL_LANDSCAPE_WIDTH 260
#define CELL_LANDSCAPE_HEIGHT 50
#define CELL_LANDSCAPE_MARGIN 15
#define CELL_PORTRAIT_WIDTH 290
#define CELL_PORTRAIT_HEIGHT 50
#define CELL_PORTRAIT_MARGIN 15

#define VIEW_PADDING 15

#define SUPPLEMENTARY_VIEW_ID_HEADER @"HeaderViewID"
#define HEADER_HEIGHT 60

@implementation RecipeViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Collection view
	self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
	[self.collectionView registerClass:[IngredientCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID_INGREDIENT];
	[self.collectionView registerClass:[IngredientSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SUPPLEMENTARY_VIEW_ID_HEADER];
	self.collectionView.dataSource = self;
	self.collectionView.delegate = self;
	self.collectionView.backgroundView = nil;
	self.collectionView.backgroundColor = [UIColor clearColor];
	self.collectionView.alwaysBounceVertical = YES;
	self.collectionView.showsHorizontalScrollIndicator = NO;
	self.collectionView.showsVerticalScrollIndicator = NO;
	self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;

	CGFloat barsHeight = [self barsHeight];

	// Offset the collection view to avoid being hidden behind the navbar and status bar
	self.collectionView.contentInset = UIEdgeInsetsMake(barsHeight, VIEW_PADDING, 0, VIEW_PADDING);
	[self.view addSubview:self.collectionView];
	[self.collectionView constraintToSuperViewCover];

	// No recommendation: message
	self.noRecipeMessageLabel = [UILabel new];
	self.noRecipeMessageLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE];
	self.noRecipeMessageLabel.textColor = APP_TEXT_COLOR;
	self.noRecipeMessageLabel.textAlignment = NSTextAlignmentCenter;
	self.noRecipeMessageLabel.text = NSLocalizedString(@"No_Recommendation_Message", nil);
	self.noRecipeMessageLabel.numberOfLines = 0;
	self.noRecipeMessageLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.noRecipeMessageLabel];
	[self.noRecipeMessageLabel constraintToSuperViewTop:(barsHeight + 10)];
	[self.noRecipeMessageLabel constraintToSuperViewCenterHorizontallyMargin:VIEW_PADDING];
	[self.noRecipeMessageLabel constraintToHeight:0];

	if (self.recipe)
	{
		self.navigationItem.title = NSLocalizedString(@"Recommendation", nil);
		self.collectionView.hidden = NO;
		self.noRecipeMessageLabel.hidden = YES;
	}
	else
	{
		self.navigationItem.title = NSLocalizedString(@"No_Recommendation_Title", nil);
		self.collectionView.hidden = YES;
		self.noRecipeMessageLabel.hidden = NO;
	}
}

- (void)viewDidLayoutSubviews
{
	[self.view layoutIfNeeded];

	// Layout the no recipe message
	self.noRecipeMessageLabel.preferredMaxLayoutWidth = self.view.frameWidth - VIEW_PADDING * 2;
	self.noRecipeMessageLabel.getConstraintToHeight.constant = self.noRecipeMessageLabel.intrinsicContentSize.height;

	[self.view layoutSubviews];
}


/* ================================= COLLECTION VIEW DATASOURCE / DELEGATE =================================== */

/* Ingredients */

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.recipe.ingredients.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	Ingredient *ingredient = self.recipe.ingredients[indexPath.row];

	// Each cell is an ingredient
	IngredientCollectionViewCell *cell = (IngredientCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID_INGREDIENT forIndexPath:indexPath];
	[cell setupSubviewsWithIngredient:ingredient];

	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	IngredientSectionHeader *result = nil;

	if (kind == UICollectionElementKindSectionHeader)
	{
		// Display recipe name at the section header
		result = (IngredientSectionHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:SUPPLEMENTARY_VIEW_ID_HEADER forIndexPath:indexPath];
		[result setupSubviewsWithRecipe:self.recipe];
	}

	return result;
}


/* Layout */

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return IS_LANDSCAPE() ? CGSizeMake(CELL_LANDSCAPE_WIDTH, CELL_LANDSCAPE_HEIGHT) :
							CGSizeMake(CELL_PORTRAIT_WIDTH, CELL_PORTRAIT_HEIGHT);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return IS_LANDSCAPE() ? CELL_LANDSCAPE_MARGIN : CELL_PORTRAIT_MARGIN;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
	return CGSizeMake(0, HEADER_HEIGHT);
}

// Refresh collection view layout upon orientation change
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

	[self.collectionView.collectionViewLayout invalidateLayout];
}

@end
