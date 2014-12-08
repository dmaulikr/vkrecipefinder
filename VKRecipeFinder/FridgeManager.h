//
//  FridgeManager.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FridgeManager : NSObject

+ (FridgeManager *)sharedInstance;

- (NSArray *)readAvailabilitesFromFile:(NSString *)filePath;

@end
