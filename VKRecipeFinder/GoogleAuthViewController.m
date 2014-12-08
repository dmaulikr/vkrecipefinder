//
//  GoogleAuthViewController.m
//
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "GoogleAuthViewController.h"

@implementation GoogleAuthViewController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(touchedCancelButton)];
}

- (void)touchedCancelButton
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
