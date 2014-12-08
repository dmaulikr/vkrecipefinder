//
//  Ingredient.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property (strong, nonatomic) NSString *item;
@property (assign, nonatomic) int amount;
@property (strong, nonatomic) NSString *unit;

@end
