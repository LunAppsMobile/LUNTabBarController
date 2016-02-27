//
// Created by Victor Sharavara on 2/11/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LUNTabBarAnimationController : UIPercentDrivenInteractiveTransition <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

/**
 @brief Specifies whether view controller is presented or dismissed
 */
@property (nonatomic) BOOL isPresenting;

/**
 @brief Specifies floating content height.
 */
@property (nonatomic) CGFloat floatingContentHeight;

/**
 @brief Specifies duration in seconds of the animated transition
 */
@property (nonatomic) CGFloat transitionDuration;

/**
 @brief Specifies scale multiplier to be applied to the background view
 */
@property (nonatomic) CGFloat scaleMultiplier;

/**
 @brief Specifies alpha multiplier to be applied to the background view
 */
@property (nonatomic) CGFloat alphaMultiplier;

@end