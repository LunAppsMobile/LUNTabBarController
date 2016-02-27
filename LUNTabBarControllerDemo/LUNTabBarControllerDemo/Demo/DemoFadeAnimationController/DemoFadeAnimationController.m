//
// Created by Victor Sharavara on 2/25/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import "DemoFadeAnimationController.h"

@implementation DemoFadeAnimationController

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    [containerView addSubview:toViewController.view];
    [containerView addSubview:fromViewController.view];

    [UIView animateWithDuration:duration
                     animations:^{
                         fromViewController.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];

                         fromViewController.view.alpha = 1;
                     }];
}

@end