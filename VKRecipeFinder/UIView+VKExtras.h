//
//  UIView+VKExtras.h
//  VKFramework
//
//  Created by Vinh Khoa Nguyen on 14/12/13.
//  Copyright (c) 2013 Vinh Khoa Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Geometry.h"


/* ================================= VK CONSTANT KEYS =================================== */

extern NSString *const VKConstraintToSuperViewTop;
extern NSString *const VKConstraintToSuperViewBottom;
extern NSString *const VKConstraintToSuperViewLeft;
extern NSString *const VKConstraintToSuperViewRight;
extern NSString *const VKConstraintToSuperViewLeading;
extern NSString *const VKConstraintToSuperViewTrailing;
extern NSString *const VKConstraintToSuperViewCenterHorizontally;
extern NSString *const VKConstraintToSuperViewCenterVertically;
extern NSString *const VKConstraintToSuperViewWidth;
extern NSString *const VKConstraintToSuperViewHeight;
extern NSString *const VKConstraintToWidth;
extern NSString *const VKConstraintToHeight;
extern NSString *const VKConstraintToCenterX;
extern NSString *const VKConstraintToCenterY;



/* ================================= INTERFACE (CATEGORY) =================================== */

@interface UIView (VKExtras)

// Auto layout
- (NSLayoutConstraint *)constraintToWidth:(CGFloat)width;
- (NSLayoutConstraint *)constraintToSelfWidth;
- (NSLayoutConstraint *)constraintToHeight:(CGFloat)height;
- (NSLayoutConstraint *)constraintToSelfHeight;
- (NSDictionary *)constraintToSize:(CGSize)size;
- (NSDictionary *)constraintToSelfSize;

- (NSLayoutConstraint *)constraintToSuperViewTop:(CGFloat)top;
- (NSLayoutConstraint *)constraintToSuperViewBottom:(CGFloat)bottom;
- (NSLayoutConstraint *)constraintToSuperViewLeft:(CGFloat)left;
- (NSLayoutConstraint *)constraintToSuperViewRight:(CGFloat)right;
- (NSLayoutConstraint *)constraintToSuperViewLeading:(CGFloat)leading;
- (NSLayoutConstraint *)constraintToSuperViewTrailing:(CGFloat)trailing;

- (NSLayoutConstraint *)constraintToSuperViewCenterHorizontally;
- (NSDictionary *)constraintToSuperViewCenterHorizontallyMargin:(CGFloat)margin;
- (NSLayoutConstraint *)constraintToSuperViewCenterVertically;
- (NSDictionary *)constraintToSuperViewCenterVerticallyMargin:(CGFloat)margin;
- (NSDictionary *)constraintToSuperViewCenter;

- (NSLayoutConstraint *)constraintToSuperViewWidth;
- (NSLayoutConstraint *)constraintToSuperViewWidthConstant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintToSuperViewWidthMultiplier:(CGFloat)multiplier;
- (NSLayoutConstraint *)constraintToSuperViewWidthMultiplier:(CGFloat)multiplier constant:(CGFloat)constant;
- (NSDictionary *)constraintToSuperViewWidthCover;

- (NSLayoutConstraint *)constraintToSuperViewHeight;
- (NSLayoutConstraint *)constraintToSuperViewHeightConstant:(CGFloat)constant;
- (NSLayoutConstraint *)constraintToSuperViewHeightMultiplier:(CGFloat)multiplier;
- (NSLayoutConstraint *)constraintToSuperViewHeightMultiplier:(CGFloat)multiplier constant:(CGFloat)constant;
- (NSDictionary *)constraintToSuperViewHeightCover;

- (NSDictionary *)constraintToSuperViewCover;

- (NSDictionary *)constraintToSuperViewLeftEdgeMargin:(CGFloat)margin;
- (NSDictionary *)constraintToSuperViewRightEdgeMargin:(CGFloat)margin;
- (NSDictionary *)constraintToSuperViewTopEdgeMargin:(CGFloat)margin;
- (NSDictionary *)constraintToSuperViewBottomEdgeMargin:(CGFloat)margin;
- (NSDictionary *)constraintToSuperViewLeadingEdgeMargin:(CGFloat)margin;
- (NSDictionary *)constraintToSuperViewTrailingEdgeMargin:(CGFloat)margin;

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview andSubview:(UIView *)secondSubview xDistance:(CGFloat)distance;
- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview andSubview:(UIView *)secondSubview yDistance:(CGFloat)distance;

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview leadingAlignWithSubview:(UIView *)secondSubview;
- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview trailingAlignWithSubview:(UIView *)secondSubview;
- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview topAlignWithSubview:(UIView *)secondSubview;
- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview bottomAlignWithSubview:(UIView *)secondSubview;
- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview centerHorizontallyWithSubview:(UIView *)secondSubview;
- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview centerVerticallyWithSubview:(UIView *)secondSubview;
- (NSDictionary *)constraintSubview:(UIView *)firstSubview centerWithSubview:(UIView *)secondSubview;

- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview sameWidthWithSubview:(UIView *)secondSubview;
- (NSLayoutConstraint *)constraintSubview:(UIView *)firstSubview sameHeightWithSubview:(UIView *)secondSubview;
- (NSDictionary *)constraintSubview:(UIView *)firstSubview sameSizeWithSubview:(UIView *)secondSubview;

- (NSLayoutConstraint *)getConstraintToSuperViewLeft;
- (NSLayoutConstraint *)getConstraintToSuperViewRight;
- (NSLayoutConstraint *)getConstraintToSuperViewTop;
- (NSLayoutConstraint *)getConstraintToSuperViewBottom;
- (NSLayoutConstraint *)getConstraintToWidth;
- (NSLayoutConstraint *)getConstraintToHeight;

- (NSArray *)getConstraintsWithItem:(id)item;
- (NSArray *)getConstraintsToItem:(id)item;
- (NSArray *)getConstraintsWithSelf;
- (NSArray *)getConstraintsToSelf;

@end
