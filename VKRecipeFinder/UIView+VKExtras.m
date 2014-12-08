//
//  UIView+VKExtras.m
//  VKFramework
//
//  Created by Vinh Khoa Nguyen on 14/12/13.
//  Copyright (c) 2013 Vinh Khoa Nguyen. All rights reserved.
//

#import "UIView+VKExtras.h"

@implementation UIView (VKExtras)


/* ================================= VK CONSTANT KEYS =================================== */

NSString *const VKConstraintToSuperViewTop		= @"VKConstraintToSuperViewTop";
NSString *const VKConstraintToSuperViewBottom	= @"VKConstraintToSuperViewBottom";
NSString *const VKConstraintToSuperViewLeft		= @"VKConstraintToSuperViewLeft";
NSString *const VKConstraintToSuperViewRight	= @"VKConstraintToSuperViewRight";
NSString *const VKConstraintToSuperViewLeading	= @"VKConstraintToSuperViewLeading";
NSString *const VKConstraintToSuperViewTrailing	= @"VKConstraintToSuperViewTrailing";
NSString *const VKConstraintToSuperViewCenterHorizontally	= @"VKConstraintToSuperViewCenterHorizontally";
NSString *const VKConstraintToSuperViewCenterVertically		= @"VKConstraintToSuperViewCenterVertically";
NSString *const VKConstraintToSuperViewWidth	= @"VKConstraintToSuperViewWidth";
NSString *const VKConstraintToSuperViewHeight	= @"VKConstraintToSuperViewHeight";
NSString *const VKConstraintToWidth				= @"VKConstraintToWidth";
NSString *const VKConstraintToHeight			= @"VKConstraintToHeight";
NSString *const VKConstraintToCenterX			= @"VKConstraintToCenterX";
NSString *const VKConstraintToCenterY			= @"VKConstraintToCenterY";



/* ================================= AUTO LAYOUT: SET CONSTRAINTS =================================== */

/* ===================== Size ===================== */

- (NSLayoutConstraint *)constraintToWidth:(CGFloat)width
{
	self.frameWidth = width;

	return [self constraintToSelfWidth];
}

- (NSLayoutConstraint *)constraintToHeight:(CGFloat)height
{
	self.frameHeight = height;

	return [self constraintToSelfHeight];
}

- (NSDictionary *)constraintToSize:(CGSize)size
{
	self.frameWidth = size.width;
	self.frameHeight = size.height;

	return [self constraintToSelfSize];
}


- (NSLayoutConstraint *)constraintToSelfWidth
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.frameWidth];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintToSelfHeight
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:0 attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.frameHeight];

	[self addConstraint:result];

	return result;
}

- (NSDictionary *)constraintToSelfSize
{
	NSLayoutConstraint *widthConstraint = [self constraintToSelfWidth];
	NSLayoutConstraint *heightConstraint = [self constraintToSelfHeight];

	return [NSDictionary dictionaryWithObjectsAndKeys:
				widthConstraint,	VKConstraintToWidth,
				heightConstraint,	VKConstraintToHeight,
			nil];
}



/* ===================== Margin to superview ===================== */

- (NSLayoutConstraint *)constraintToSuperViewTop:(CGFloat)top
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1 constant:top];

	[self.superview addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintToSuperViewBottom:(CGFloat)bottom
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-bottom];

	[self.superview addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintToSuperViewLeft:(CGFloat)left
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:left];

	[self.superview addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintToSuperViewRight:(CGFloat)right
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-right];

	[self.superview addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintToSuperViewLeading:(CGFloat)leading
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:leading];

	[self.superview addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintToSuperViewTrailing:(CGFloat)trailing
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-trailing];

	[self.superview addConstraint:result];

	return result;
}


/* ===================== Center in superview ===================== */

- (NSLayoutConstraint *)constraintToSuperViewCenterHorizontally
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];

	[self.superview addConstraint:result];

	return result;
}

- (NSDictionary *)constraintToSuperViewCenterHorizontallyMargin:(CGFloat)margin
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
				[self constraintToSuperViewLeading:margin],				VKConstraintToSuperViewLeading,
				[self constraintToSuperViewWidthConstant:-margin * 2],	VKConstraintToSuperViewWidth,
			nil];
}

- (NSLayoutConstraint *)constraintToSuperViewCenterVertically
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];

	[self.superview addConstraint:result];

	return result;
}

- (NSDictionary *)constraintToSuperViewCenterVerticallyMargin:(CGFloat)margin
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
				[self constraintToSuperViewTop:margin],					VKConstraintToSuperViewTop,
				[self constraintToSuperViewHeightConstant:-margin * 2],	VKConstraintToSuperViewBottom,
			nil];
}

- (NSDictionary *)constraintToSuperViewCenter
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
				[self constraintToSuperViewCenterHorizontally],	VKConstraintToSuperViewCenterHorizontally,
				[self constraintToSuperViewCenterVertically],	VKConstraintToSuperViewCenterVertically,
			nil];
}




/* ===================== Size with superview ===================== */

/* =========== Width ===========*/

- (NSLayoutConstraint *)constraintToSuperViewWidth
{
	return [self constraintToSuperViewWidthMultiplier:1 constant:0];
}

- (NSLayoutConstraint *)constraintToSuperViewWidthConstant:(CGFloat)constant
{
	return [self constraintToSuperViewWidthMultiplier:1 constant:constant];
}

- (NSLayoutConstraint *)constraintToSuperViewWidthMultiplier:(CGFloat)multiplier
{
	return [self constraintToSuperViewWidthMultiplier:multiplier constant:0];
}

- (NSLayoutConstraint *)constraintToSuperViewWidthMultiplier:(CGFloat)multiplier constant:(CGFloat)constant
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:multiplier constant:constant];

	[self.superview addConstraint:result];

	return result;
}

- (NSDictionary *)constraintToSuperViewWidthCover
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
				[self constraintToSuperViewLeading:0],	VKConstraintToSuperViewLeading,
				[self constraintToSuperViewWidth],		VKConstraintToSuperViewWidth,
			nil];
}


/* =========== Height ===========*/

- (NSLayoutConstraint *)constraintToSuperViewHeight
{
	return [self constraintToSuperViewHeightMultiplier:1 constant:0];
}

- (NSLayoutConstraint *)constraintToSuperViewHeightConstant:(CGFloat)constant
{
	return [self constraintToSuperViewHeightMultiplier:1 constant:constant];
}

- (NSLayoutConstraint *)constraintToSuperViewHeightMultiplier:(CGFloat)multiplier
{
	return [self constraintToSuperViewHeightMultiplier:multiplier constant:0];
}

- (NSLayoutConstraint *)constraintToSuperViewHeightMultiplier:(CGFloat)multiplier constant:(CGFloat)constant
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:multiplier constant:constant];

	[self.superview addConstraint:result];

	return result;
}

- (NSDictionary *)constraintToSuperViewHeightCover
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
				[self constraintToSuperViewTop:0],	VKConstraintToSuperViewTop,
				[self constraintToSuperViewHeight],	VKConstraintToSuperViewHeight,
			nil];
}


/* =========== Both Width & Height ===========*/

- (NSDictionary *)constraintToSuperViewCover
{
	NSMutableDictionary *result = [NSMutableDictionary dictionary];

	[result addEntriesFromDictionary:[self constraintToSuperViewWidthCover]];
	[result addEntriesFromDictionary:[self constraintToSuperViewHeightCover]];

	return result;
}


/* ===================== Position in superview ===================== */

- (NSDictionary *)constraintToSuperViewLeftEdgeMargin:(CGFloat)margin
{
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[self constraintToSuperViewHeightCover]];
	[result setObject:[self constraintToSuperViewLeft:margin] forKey:VKConstraintToSuperViewLeft];

	return result;
}

- (NSDictionary *)constraintToSuperViewRightEdgeMargin:(CGFloat)margin
{
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[self constraintToSuperViewHeightCover]];
	[result setObject:[self constraintToSuperViewRight:margin] forKey:VKConstraintToSuperViewRight];

	return result;
}

- (NSDictionary *)constraintToSuperViewLeadingEdgeMargin:(CGFloat)margin
{
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[self constraintToSuperViewHeightCover]];
	[result setObject:[self constraintToSuperViewLeading:margin] forKey:VKConstraintToSuperViewLeading];

	return result;
}

- (NSDictionary *)constraintToSuperViewTrailingEdgeMargin:(CGFloat)margin
{
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[self constraintToSuperViewHeightCover]];
	[result setObject:[self constraintToSuperViewTrailing:margin] forKey:VKConstraintToSuperViewTrailing];

	return result;
}

- (NSDictionary *)constraintToSuperViewTopEdgeMargin:(CGFloat)margin
{
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[self constraintToSuperViewWidthCover]];
	[result setObject:[self constraintToSuperViewTop:margin] forKey:VKConstraintToSuperViewTop];

	return [NSDictionary dictionaryWithDictionary:result];
}

- (NSDictionary *)constraintToSuperViewBottomEdgeMargin:(CGFloat)margin
{
	NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[self constraintToSuperViewWidthCover]];
	[result setObject:[self constraintToSuperViewBottom:margin] forKey:VKConstraintToSuperViewBottom];

	return [NSDictionary dictionaryWithDictionary:result];
}


/* ===================== Subviews x, y margins ===================== */

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview andSubview:(UIView *)secondSubview xDistance:(CGFloat)distance
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeLeft multiplier:1 constant:-distance];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview andSubview:(UIView *)secondSubview yDistance:(CGFloat)distance
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeTop multiplier:1 constant:-distance];

	[self addConstraint:result];

	return result;
}


/* ===================== Subviews alignment ===================== */

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview leadingAlignWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview trailingAlignWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview topAlignWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeTop multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview bottomAlignWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview centerHorizontallyWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview centerVerticallyWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSDictionary *)constraintSubview:(UIView *)firstSubview centerWithSubview:(UIView *)secondSubview
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
				[self constraintSubview:firstSubview centerHorizontallyWithSubview:secondSubview],	VKConstraintToCenterX,
				[self constraintSubview:firstSubview centerVerticallyWithSubview:secondSubview],	VKConstraintToCenterY,
			nil];
}


/* ===================== Subviews size ===================== */

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview sameWidthWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeWidth multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview sameHeightWithSubview:(UIView *)secondSubview
{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:firstSubview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:secondSubview attribute:NSLayoutAttributeHeight multiplier:1 constant:0];

	[self addConstraint:result];

	return result;
}

- (NSDictionary *)constraintSubview:(UIView *)firstSubview sameSizeWithSubview:(UIView *)secondSubview
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
				[self constraintSubview:firstSubview sameWidthWithSubview:secondSubview],	VKConstraintToWidth,
				[self constraintSubview:firstSubview sameHeightWithSubview:secondSubview],	VKConstraintToHeight,
			nil];
}



/* ================================= AUTO LAYOUT: GET CONSTRAINTS =================================== */

- (NSLayoutConstraint *)getConstraintToSuperViewLeft
{
	// Limit by left constraints
	NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"firstAttribute = %ld",	(long)NSLayoutAttributeLeft]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"relation = %ld", 			(long)NSLayoutRelationEqual]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"secondAttribute = %ld",	(long)NSLayoutAttributeLeft]],
		[NSPredicate predicateWithFormat:@"multiplier = 1"]
	]];

	return [self getConstraintToSuperViewMatchingPredicate:compoundPredicate];
}

- (NSLayoutConstraint *)getConstraintToSuperViewRight
{
	// Limit by right constraints
	NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"firstAttribute = %ld",	(long)NSLayoutAttributeRight]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"relation = %ld", 			(long)NSLayoutRelationEqual]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"secondAttribute = %ld",	(long)NSLayoutAttributeRight]],
		[NSPredicate predicateWithFormat:@"multiplier = 1"]
	]];

	return [self getConstraintToSuperViewMatchingPredicate:compoundPredicate];
}

- (NSLayoutConstraint *)getConstraintToSuperViewTop
{
	// Limit by top constraints
	NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"firstAttribute = %ld",	(long)NSLayoutAttributeTop]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"relation = %ld", 			(long)NSLayoutRelationEqual]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"secondAttribute = %ld",	(long)NSLayoutAttributeTop]],
		[NSPredicate predicateWithFormat:@"multiplier = 1"]
	]];

	return [self getConstraintToSuperViewMatchingPredicate:compoundPredicate];
}

- (NSLayoutConstraint *)getConstraintToSuperViewBottom
{
	// Limit by bottom constraints
	NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"firstAttribute = %ld",	(long)NSLayoutAttributeBottom]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"relation = %ld", 			(long)NSLayoutRelationEqual]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"secondAttribute = %ld",	(long)NSLayoutAttributeBottom]],
		[NSPredicate predicateWithFormat:@"multiplier = 1"]
	]];

	return [self getConstraintToSuperViewMatchingPredicate:compoundPredicate];
}

- (NSLayoutConstraint *)getConstraintToWidth
{
	// Limit by width constraints
	NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"firstAttribute = %ld",	(long)NSLayoutAttributeWidth]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"relation = %ld", 			(long)NSLayoutRelationEqual]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"secondAttribute = %ld",	(long)NSLayoutAttributeNotAnAttribute]],
		[NSPredicate predicateWithFormat:@"multiplier = 1"]
	]];

	return [self getConstraintToSelfMatchingPredicate:compoundPredicate];
}

- (NSLayoutConstraint *)getConstraintToHeight
{
	// Limit by height constraints
	NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"firstAttribute = %ld",	(long)NSLayoutAttributeHeight]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"relation = %ld", 			(long)NSLayoutRelationEqual]],
		[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"secondAttribute = %ld",	(long)NSLayoutAttributeNotAnAttribute]],
		[NSPredicate predicateWithFormat:@"multiplier = 1"]
	]];

	return [self getConstraintToSelfMatchingPredicate:compoundPredicate];
}

- (NSLayoutConstraint *)getConstraintToSuperViewMatchingPredicate:(NSPredicate *)predicate
{
	NSArray *arrFilteredConstraints = [self.superview.constraints filteredArrayUsingPredicate:predicate];

	NSLayoutConstraint *result;
	for (NSLayoutConstraint *constraint in arrFilteredConstraints)
	{
		if ((constraint.firstItem == self) && (constraint.secondItem == self.superview))
		{
			result = constraint;
			break;
		}
	}

	return result;
}

- (NSLayoutConstraint *)getConstraintToSelfMatchingPredicate:(NSPredicate *)predicate
{
	NSArray *arrFilteredConstraints = [self.constraints filteredArrayUsingPredicate:predicate];

	NSLayoutConstraint *result;
	for (NSLayoutConstraint *constraint in arrFilteredConstraints)
	{
		if ((constraint.firstItem == self) && (constraint.secondItem == nil))
		{
			result = constraint;
			break;
		}
	}

	return result;
}

- (NSArray *)getConstraintsWithItem:(id)item
{
	NSMutableArray *result = [NSMutableArray array];
	for (NSLayoutConstraint *constraint in self.constraints)
	{
		if (constraint.firstItem == item)
		{
			[result addObject:constraint];
		}
	}

	return [NSArray arrayWithArray:result];
}

- (NSArray *)getConstraintsToItem:(id)item
{
	NSMutableArray *result = [NSMutableArray array];
	for (NSLayoutConstraint *constraint in self.constraints)
	{
		if (constraint.secondItem == item)
		{
			[result addObject:constraint];
		}
	}

	return [NSArray arrayWithArray:result];
}

- (NSArray *)getConstraintsWithSelf
{
	return [self getConstraintsWithItem:self];
}

- (NSArray *)getConstraintsToSelf
{
	return [self getConstraintsToItem:self];
}

@end
