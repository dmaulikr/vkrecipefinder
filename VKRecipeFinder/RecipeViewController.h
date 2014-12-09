//
//  RecipeViewController.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipe;

@interface RecipeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) Recipe *recipe;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UILabel *noRecipeMessageLabel;

@end
