//
//  ViewController.h
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 8/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoogleDriveButton, RemoveGoogleAccountButton;

@interface ViewController : UIViewController

@property (strong, nonatomic) GoogleDriveButton *googleDriveButton;
@property (strong, nonatomic) RemoveGoogleAccountButton *removeGoogleAccountButton;
@property (strong, nonatomic) UILabel *instructionsLabel;

@end

