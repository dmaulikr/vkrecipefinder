//
//  IngredientCollectionViewCell.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "IngredientCollectionViewCell.h"
#import "Ingredient.h"
#import "Constants.h"
#import "UIView+VKExtras.h"
#import "UIColor+VKExtras.h"

#define PADDING 10

@implementation IngredientCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		// Inner content view
		self.innerContentView = [UIView new];
		self.innerContentView.layer.borderWidth = 1;
		self.innerContentView.layer.borderColor = [UIColor colorWithHex:@"e1e1e1"].CGColor;
		self.innerContentView.backgroundColor = [UIColor colorWithHex:@"f9f9f9"];
		self.innerContentView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:self.innerContentView];
		[self.innerContentView constraintToSuperViewCover];

		// Item label
		self.itemLabel = [UILabel new];
		self.itemLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE];
		self.itemLabel.textColor = APP_TEXT_COLOR;
		self.itemLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.innerContentView addSubview:self.itemLabel];
		[self.itemLabel constraintToSuperViewLeftEdgeMargin:PADDING];

		// Amount label
		self.amountLabel = [UILabel new];
		self.amountLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE];
		self.amountLabel.textColor = APP_SUBTEXT_COLOR;
		self.amountLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[self.innerContentView addSubview:self.amountLabel];
		[self.amountLabel constraintToSuperViewRightEdgeMargin:PADDING];
		[self.amountLabel constraintToWidth:0];
		[self.innerContentView constraintSubview:self.itemLabel andSubview:self.amountLabel xDistance:0];
	}

	return self;
}

- (void)setupSubviewsWithIngredient:(Ingredient *)ingredient
{
	self.itemLabel.text = ingredient.item;
	self.amountLabel.text = [NSString stringWithFormat:@"%d %@", ingredient.amount, ingredient.unit];
	self.amountLabel.getConstraintToWidth.constant = self.amountLabel.intrinsicContentSize.width;
}

@end
