//
//  RemoveGoogleAccountButton.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 9/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "RemoveGoogleAccountButton.h"
#import "Constants.h"
#import "UIColor+VKExtras.h"

#define BUTTON_COLOR [UIColor colorWithHex:@"333"]
#define BUTTON_COLOR_REVERSE [UIColor colorWithHex:@"999"]
#define BUTTON_HEIGHT 30
#define PADDING_HORIZONTAL 20

@implementation RemoveGoogleAccountButton

- (id)initButtonWithTarget:(id)target action:(SEL)action
{
	// Button title
	NSString *title = NSLocalizedString(@"Remove_Account_Button_Title", nil);
	NSDictionary *dictTitleAttributes = @{
		NSFontAttributeName: [UIFont systemFontOfSize:APP_FONT_SIZE],
		NSForegroundColorAttributeName:BUTTON_COLOR
	};
	NSDictionary *dictTitleAttributesOn = @{
		NSFontAttributeName: [UIFont systemFontOfSize:APP_FONT_SIZE],
		NSForegroundColorAttributeName:BUTTON_COLOR_REVERSE
	};

	// Init button
	self = [super initWithFrame:CGRectMake(0, 0, [title sizeWithAttributes:dictTitleAttributes].width + PADDING_HORIZONTAL * 2, BUTTON_HEIGHT)];
	[self setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:dictTitleAttributes] forState:UIControlStateNormal];
	[self setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:dictTitleAttributesOn] forState:UIControlStateHighlighted];
	[self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

	return self;
}

@end
