//
//  Recipe.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *ingredients;

@end
