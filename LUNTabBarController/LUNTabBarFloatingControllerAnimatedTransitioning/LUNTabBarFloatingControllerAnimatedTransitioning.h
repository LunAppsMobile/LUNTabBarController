//
// Created by Victor Sharavara on 2/24/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LUNTabBarFloatingControllerAnimatedTransitioning <NSObject>

@optional

/**
 @brief Notifies when animated transition starts
 
 @param isPresenting Specifies whether view controller is presented or dismissed
 */
- (void)floatingViewControllerStartedAnimatedTransition:(BOOL)isPresenting;

/**
 @brief This method is used to provide additional custom animation alongside the transition
 
 @param isPresenting Specifies whether view controller is presented or dismissed
 */
- (void (^)(void))keyframeAnimationForFloatingViewControllerAnimatedTransition:(BOOL)isPresenting;

/**
 @brief Notifies when animated transition finishes
 
 @param isPresenting Specifies whether view controller is presented or dismissed
 @param wasCompleted Specifies whether transition was completed or cancelled
 */
- (void)floatingViewControllerFinishedAnimatedTransition:(BOOL)isPresenting wasCompleted:(BOOL)wasCompleted;

@end