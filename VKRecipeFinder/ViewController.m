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

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	// Google Drive button
	self.googleDriveButton = [[GoogleDriveButton alloc] initButtonWithTarget:self action:@selector(importFromGoogleDrive)];
	[self.view addSubview:self.googleDriveButton];
	self.googleDriveButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self.googleDriveButton constraintToSelfSize];
	[self.googleDriveButton constraintToSuperViewBottom:50];
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
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)importFromGoogleDrive
{
	NSLog(@"import from google drive now");
}

@end
