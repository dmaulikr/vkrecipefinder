//
//  ViewController.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 8/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "UIView+VKExtras.h"
#import "UIColor+VKExtras.h"
#import "UIViewController+Extras.h"
#import "GoogleDriveButton.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"
#import "GoogleAuthViewController.h"
#import "GoogleDrive.h"
#import "RemoveGoogleAccountButton.h"
#import "FridgeManager.h"
#import "RecipeManager.h"
#import "RecipeViewController.h"
#import "Recipe.h"
#import "Ingredient.h"

#define SEGUE_ID_GOOGLE_AUTH @"openGoogleAuth"
#define SEGUE_ID_SHOW_RECOMMENDATION @"showRecommendation"

#define VIEW_PADDING 20

@implementation ViewController
{
	Recipe *recommendedRecipe;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Google Drive button
	self.googleDriveButton = [[GoogleDriveButton alloc] initButtonWithTarget:self action:@selector(touchedImportButton)];
	[self.view addSubview:self.googleDriveButton];
	self.googleDriveButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.googleDriveButton constraintToSelfSize];
	[self.googleDriveButton constraintToSuperViewBottom:50];
	[self.googleDriveButton constraintToSuperViewCenterHorizontally];

	// Instructions
	self.instructionsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.instructionsLabel.text = NSLocalizedString(@"Instructions", nil);
	self.instructionsLabel.font = [UIFont systemFontOfSize:APP_FONT_SIZE];
	self.instructionsLabel.textColor = APP_TEXT_COLOR;
	self.instructionsLabel.numberOfLines = 0;
	[self.view addSubview:self.instructionsLabel];
	self.instructionsLabel.translatesAutoresizingMaskIntoConstraints = NO;
	[self.instructionsLabel constraintToSuperViewTop:([self barsHeight] + 10)];
	[self.instructionsLabel constraintToSuperViewCenterHorizontallyMargin:VIEW_PADDING];
	[self.instructionsLabel constraintToHeight:0];

	// Remove Google Account button
	self.removeGoogleAccountButton = [[RemoveGoogleAccountButton alloc] initButtonWithTarget:self action:@selector(touchedRemoveAccountButton)];
	[self.view addSubview:self.removeGoogleAccountButton];
	self.removeGoogleAccountButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.removeGoogleAccountButton constraintToSelfSize];
	[self.view constraintSubview:self.googleDriveButton andSubview:self.removeGoogleAccountButton yDistance:5];
	[self.removeGoogleAccountButton constraintToSuperViewCenterHorizontally];
	self.removeGoogleAccountButton.hidden = ![[GoogleDrive sharedDrive] authorizeFromKeychain];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	// Open Google Auth screen?
	if ([segue.identifier isEqualToString:SEGUE_ID_GOOGLE_AUTH])
	{
		UINavigationController *destNavVC = (UINavigationController *)segue.destinationViewController;
		destNavVC.viewControllers = @[[self createGoogleAuthViewController]];
	}

	// Show recommendation?
	else if ([segue.identifier isEqualToString:SEGUE_ID_SHOW_RECOMMENDATION])
	{
		RecipeViewController *destVC = (RecipeViewController *)segue.destinationViewController;
		destVC.recipe = self->recommendedRecipe;
	}
}

- (void)viewDidLayoutSubviews
{
	[self.view layoutIfNeeded];

	// Layout the instructions
	self.instructionsLabel.preferredMaxLayoutWidth = self.view.frameWidth - VIEW_PADDING * 2;
	self.instructionsLabel.getConstraintToHeight.constant = self.instructionsLabel.intrinsicContentSize.height;

	[self.view layoutSubviews];
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
		if (error)
		{
			UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[[error userInfo] objectForKey:KEY_ERROR_MESSAGE] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[errorAlert show];
		}
		else
		{
			// Read data from downloaded files
			NSArray *arrAvailabilities = [[FridgeManager sharedInstance] readAvailabilitesFromFile:[GoogleDrive sharedDrive].downloadedFridgeFilePath];
			NSArray *arrRecipes = [[RecipeManager sharedInstance] readRecipesFromFile:[GoogleDrive sharedDrive].downloadedRecipesFilePath];

			// Delete the downloaded files as they are no longer in use
			[[GoogleDrive sharedDrive] deleteDownloadedFiles];

			// Show the recommended recipe
			self->recommendedRecipe = [[RecipeManager sharedInstance] pickRecommendationFromRecipes:arrRecipes andAvailabilities:arrAvailabilities];
			[self performSegueWithIdentifier:SEGUE_ID_SHOW_RECOMMENDATION sender:self];
		}
	}];
}

@end
