//
//  IngredientCollectionViewCell.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Ingredient;

@interface IngredientCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIView *innerContentView;
@property (strong, nonatomic) UILabel *itemLabel, *amountLabel;

- (void)setupSubviewsWithIngredient:(Ingredient *)ingredient;

@end
