//
//  GoogleDrive.h
//
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTLServiceDrive, GTMOAuth2Authentication;

extern NSString *const GoogleDriveErrorDomain;

@interface GoogleDrive : NSObject

+ (GoogleDrive *)sharedDrive;

- (BOOL)authorizeFromKeychain;
- (BOOL)removeAuthFromKeychain;
- (void)downloadAppData:(void (^)(NSError *error))completion;
- (void)deleteDownloadedFiles;

@property (strong, nonatomic) GTMOAuth2Authentication *authorizer;
@property (strong, nonatomic, readonly) NSString *downloadedFridgeFilePath, *downloadedRecipesFilePath;

@end
