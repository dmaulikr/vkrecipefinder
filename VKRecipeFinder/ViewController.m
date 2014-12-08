//
//  ViewController.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 8/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+VKExtras.h"
#import "UIView+Geometry.h"
#import "UIView+VKExtras.h"
#import "GoogleDriveButton.h"
#import "Constants.h"
#import "UIColor+VKExtras.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"
#import "GoogleAuthViewController.h"
#import "GoogleDrive.h"
#import "RemoveGoogleAccountButton.h"
#import "FridgeManager.h"
#import "RecipeManager.h"

#define SEGUE_ID_GOOGLE_AUTH @"openGoogleAuth"

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Google Drive button
	self.googleDriveButton = [[GoogleDriveButton alloc] initButtonWithTarget:self action:@selector(touchedImportButton)];
	[self.view addSubview:self.googleDriveButton];
	self.googleDriveButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.googleDriveButton constraintToSelfSize];
	[self.googleDriveButton constraintToSuperViewBottom:60];
	[self.googleDriveButton constraintToSuperViewCenterHorizontally];

	// Instructions
	UILabel *instructionsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	instructionsLabel.text = NSLocalizedString(@"Instructions", nil);
	instructionsLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE];
	instructionsLabel.textColor = APP_TEXT_COLOR;
	instructionsLabel.numberOfLines = 0;
	[self.view addSubview:instructionsLabel];
	instructionsLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[instructionsLabel constraintToSuperViewTop:0];
	[instructionsLabel constraintToSuperViewCenterHorizontallyMargin:20];
	[self.view constraintSubview:instructionsLabel andSubview:self.googleDriveButton yDistance:0];

	// Remove Google Account button
	self.removeGoogleAccountButton = [[RemoveGoogleAccountButton alloc] initButtonWithTarget:self action:@selector(touchedRemoveAccountButton)];
	[self.view addSubview:self.removeGoogleAccountButton];
	self.removeGoogleAccountButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.removeGoogleAccountButton constraintToSelfSize];
	[self.view constraintSubview:self.googleDriveButton andSubview:self.removeGoogleAccountButton yDistance:10];
	[self.removeGoogleAccountButton constraintToSuperViewCenterHorizontally];
	self.removeGoogleAccountButton.hidden = ![[GoogleDrive sharedDrive] authorizeFromKeychain];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Open Google Auth screen?
	if ([segue.identifier isEqualToString:SEGUE_ID_GOOGLE_AUTH])
	{
		UINavigationController *destNavVC = (UINavigationController *)segue.destinationViewController;
		destNavVC.viewControllers = @[[self createGoogleAuthViewController]];
	}
}



/* ================================= GOOGLE DRIVE =================================== */

// Creates the auth controller for authorizing access to Google Drive.
- (GoogleAuthViewController *)createGoogleAuthViewController
{
	GoogleAuthViewController *authController;
	authController = [[GoogleAuthViewController alloc] initWithScope:kGTLAuthScopeDriveReadonly
							clientID:GOOGLE_PROJECT_CLIENT_ID
							clientSecret:GOOGLE_PROJECT_CLIENT_SECRET
							keychainItemName:GOOGLE_PROJECT_KEYCHAIN_ITEM_NAME
							delegate:self
							finishedSelector:@selector(googleAuthViewController:finishedWithAuth:error:)];
    return authController;
}

// Handle completion of the authorization process, and updates the Drive service with the new credentials.
- (void)googleAuthViewController:(GTMOAuth2ViewControllerTouch *)viewController finishedWithAuth:(GTMOAuth2Authentication *)authResult error:(NSError *)error
{
	if (error != nil)
	{
		// This is almost always due to user going back. So do nothing here.
		[GoogleDrive sharedDrive].authorizer = nil;
	}
	else
	{
		self.removeGoogleAccountButton.hidden = NO;
		[viewController dismissViewControllerAnimated:YES completion:^{
			[GoogleDrive sharedDrive].authorizer = authResult;
			[self importFromGoogleDrive];
		}];
	}
}

- (void)touchedImportButton
{
	// Authorize from keychain
	if ([[GoogleDrive sharedDrive] authorizeFromKeychain])
	{
		[self importFromGoogleDrive];
	}
	else
	{
		[self performSegueWithIdentifier:SEGUE_ID_GOOGLE_AUTH sender:self];
	}
}

- (void)touchedRemoveAccountButton
{
	// Remove current Google account authorization from keychain
	[[GoogleDrive sharedDrive] removeAuthFromKeychain];
	self.removeGoogleAccountButton.hidden = YES;
}

- (void)importFromGoogleDrive
{
	[[GoogleDrive sharedDrive] downloadAppData:^(NSError *error) {
		// Read data from downloaded files
		NSArray *arrAvailabilities = [[FridgeManager sharedInstance] readAvailabilitesFromFile:[GoogleDrive sharedDrive].downloadedFridgeFilePath];
		NSArray *arrRecipes = [[RecipeManager sharedInstance] readRecipesFromFile:[GoogleDrive sharedDrive].downloadedRecipesFilePath];

		// Pick recommendation
		[[RecipeManager sharedInstance] pickRecommendationFromRecipes:arrRecipes andAvailabilities:arrAvailabilities];
	}];
}

@end
