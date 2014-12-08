//
//  GoogleDrive.m
//
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "GoogleDrive.h"
#import "GTLDrive.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "Constants.h"

NSString *const GoogleDriveErrorDomain = @"GoogleDriveErrorDomain";

@implementation GoogleDrive
{
	GTLServiceDrive *driveService;
}

+ (GoogleDrive *)sharedDrive
{
	static GoogleDrive *sharedDrive;

	@synchronized(self)
	{
		if (!sharedDrive)
		{
			sharedDrive = [[GoogleDrive alloc] init];
		}

		return sharedDrive;
	}
}

- (id)init
{
	self = [super init];

	self->driveService = [[GTLServiceDrive alloc] init];

	return self;
}



/* ================================= AUTHORIZATION =================================== */

// Get authorizer from keychain. Or return nil if none exists or it cannot authorize anymore.
- (BOOL)authorizeFromKeychain
{
	self->driveService.authorizer = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:GOOGLE_PROJECT_KEYCHAIN_ITEM_NAME clientID:GOOGLE_PROJECT_CLIENT_ID clientSecret:GOOGLE_PROJECT_CLIENT_SECRET];

	return ([self->driveService.authorizer canAuthorize]);
}

- (BOOL)removeAuthFromKeychain
{
	BOOL removeResult = [GTMOAuth2ViewControllerTouch removeAuthFromKeychainForName:GOOGLE_PROJECT_KEYCHAIN_ITEM_NAME];
	self->driveService.authorizer = nil;

	return removeResult;
}

- (GTMOAuth2Authentication *)authorizer
{
	return self->driveService.authorizer;
}

- (void)setAuthorizer:(GTMOAuth2Authentication *)authorizer
{
	self->driveService.authorizer = authorizer;
}



/* ================================= FILE DOWNLOADS =================================== */

- (NSString *)downloadedFridgeFilePath
{
	return [NSTemporaryDirectory() stringByAppendingPathComponent:GDRIVE_FILE_FRIDGE];
}

- (NSString *)downloadedRecipesFilePath
{
	return [NSTemporaryDirectory() stringByAppendingPathComponent:GDRIVE_FILE_RECIPES];
}

- (void)downloadFileName:(NSString *)fileName storeAtLocalPath:(NSString *)filePath completion:(void(^)(NSError *error))completion
{
	GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
	query.q = [NSString stringWithFormat:@"title = '%@'", fileName];

	[self->driveService executeQuery:query completionHandler:^(GTLServiceTicket *ticket, id object, NSError *error) {

		// Any error with the query?
		if (error == nil)
		{
			GTLDriveFileList *files = (GTLDriveFileList *)object;

			// Any file found?
			if (files.items.count)
			{
				// Download the first one found. User should have only one matching this name anyway.
				NSString *downloadURL = ((GTLDriveFile *)files.items[0]).downloadUrl;
				GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithURLString:downloadURL];
				fetcher.authorizer = self->driveService.authorizer;
				fetcher.downloadPath = filePath;

				// Start downloading
				[fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {
					if (completion) completion(error);
				}];
			}
			else
			{
				NSError *returnError = [NSError errorWithDomain:GoogleDriveErrorDomain code:404 userInfo:@{KEY_ERROR_MESSAGE: [NSString stringWithFormat:@"File not found on Google Drive: %@", fileName]}];
				completion(returnError);
			}
		}
		else
		{
			completion(error);
		}
	}];
}

- (void)downloadAppData:(void (^)(NSError *error))completion
{
	// Download the fridge file
	[self downloadFileName:GDRIVE_FILE_FRIDGE storeAtLocalPath:self.downloadedFridgeFilePath completion:^(NSError *error) {
		// Any error?
		if (error)
		{
			completion(error);
		}
		else
		{
			// Download the recipes files
			[self downloadFileName:GDRIVE_FILE_RECIPES storeAtLocalPath:self.downloadedRecipesFilePath completion:^(NSError *error) {
				completion(error);
			}];
		}
	}];
}

@end
