//
//  UIViewController+Extras.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "UIViewController+Extras.h"
#import "UIView+VKExtras.h"

@implementation UIViewController (Extras)

- (CGFloat)barsHeight
{
	CGFloat statusBarHeight = MIN([UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height);
	CGFloat navBarHeight = MIN(self.navigationController.navigationBar.frameWidth, self.navigationController.navigationBar.frameHeight);
	CGFloat barsHeight = navBarHeight + statusBarHeight;

	return barsHeight;
}

@end
