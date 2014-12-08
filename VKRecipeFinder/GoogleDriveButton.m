//
//  GoogleDriveButton.m
//  VKRecipeFinder
//
//  Created by Vinh Khoa Nguyen on 8/12/2014.
//  Copyright (c) 2014 Vinh Khoa Nguyen. All rights reserved.
//

#import "GoogleDriveButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+VKExtras.h"
#import "Constants.h"

#define BUTTON_COLOR [UIColor colorWithHex:@"d35400"]
#define BUTTON_COLOR_REVERSE [UIColor whiteColor]
#define BUTTON_HEIGHT 50
#define PADDING_HORIZONTAL 20

@implementation GoogleDriveButton

- (id)initButtonWithTarget:(id)target action:(SEL)action
{
	// Button title
	NSString *title = NSLocalizedString(@"Import_Button_Title", nil);
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
	self.layer.borderWidth = 1;
	self.layer.borderColor = BUTTON_COLOR.CGColor;
	[self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

	return self;
}


/* ================================= HIGHTLIGHTED & SELECTED STATES =================================== */

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];

	// Button currently selected? Keep it that way
	BOOL status = (self.selected) ? YES : highlighted;
	[self updateApperanceForStatus:status];
}

- (void)setSelected:(BOOL)selected
{
	[super setSelected:selected];

	[self updateApperanceForStatus:selected];
}

- (void)updateApperanceForStatus:(BOOL)status
{
	if (status)
	{
		self.backgroundColor = BUTTON_COLOR;
	}
	else
	{
		self.backgroundColor = BUTTON_COLOR_REVERSE;
	}
}

@end
