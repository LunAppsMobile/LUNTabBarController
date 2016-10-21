//
// Created by Victor Sharavara on 2/11/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import "LUNTabBarAnimationController.h"
#import "LUNTabBarFloatingControllerAnimatedTransitioning.h"

@interface LUNTabBarAnimationController ()

@property (nonatomic, strong) UIView *backgroundSnapshot;
@property (nonatomic, strong) UIView *tabBarSnapshot;

- (UIView *)createBackgroundSnapshot:(UIViewController *)backgroundViewController;

- (UIView *)createTabBarSnapshot:(UITabBarController *)tabBarController;

@end

@implementation LUNTabBarAnimationController

- (UIView *)createBackgroundSnapshot:(UIViewController *)backgroundViewController {
    UIView *view = backgroundViewController.view;
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *snapshotView = [[UIImageView alloc] initWithImage:snapshotImage];
    snapshotView.frame = view.frame;
    snapshotView.layer.shadowColor = [UIColor blackColor].CGColor;
    snapshotView.layer.shadowOffset = CGSizeMake(0, 1);
    snapshotView.layer.shadowOpacity = 0.1;
    snapshotView.layer.shadowRadius = 11;

    return snapshotView;
}

- (UIView *)createTabBarSnapshot:(UITabBarController *)tabBarController {
    UITabBar *tabBar = tabBarController.tabBar;
    CGSize tabBarControllerViewSize = tabBarController.view.frame.size;
    CGRect tabBarFrame = tabBar.frame;

    BOOL hasShadow = !tabBar.backgroundImage || !tabBar.shadowImage;
    if (hasShadow) {
        tabBarFrame.size.height += 1.0f / [UIScreen mainScreen].scale;
        tabBarFrame.origin.y -= 1.0f / [UIScreen mainScreen].scale;
    }

    UIGraphicsBeginImageContextWithOptions(tabBarFrame.size, NO, [UIScreen mainScreen].scale);
    [tabBarController.view drawViewHierarchyInRect:CGRectMake(0, -tabBarFrame.origin.y, tabBarControllerViewSize.width, tabBarControllerViewSize.height) afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageView *snapshotView = [[UIImageView alloc] initWithImage:snapshotImage];
    snapshotView.frame = tabBarFrame;
    return snapshotView;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return self.transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    UIViewController *floatingViewController = self.isPresenting ? toViewController : fromViewController;
    UIViewController *backgroundViewController = self.isPresenting ? fromViewController : toViewController;

    UITabBarController *tabBarController = fromViewController.tabBarController;

    if (self.isPresenting) {
        self.backgroundSnapshot = [self createBackgroundSnapshot:backgroundViewController];
        self.tabBarSnapshot = [self createTabBarSnapshot:tabBarController];

        [backgroundViewController.view removeFromSuperview];

        [containerView addSubview:self.backgroundSnapshot];
        [containerView addSubview:floatingViewController.view];
        [containerView addSubview:self.tabBarSnapshot];

        tabBarController.tabBar.alpha = 0;
    }

    CGFloat translationDistance = self.floatingContentHeight - self.tabBarSnapshot.bounds.size.height;
    CGAffineTransform floatingHiddenTransform = CGAffineTransformMakeTranslation(0, translationDistance);
    CGAffineTransform backgroundHiddenTransform = CGAffineTransformMakeScale(self.scaleMultiplier, self.scaleMultiplier);
    CGAffineTransform tabBarHiddenTransform = CGAffineTransformMakeTranslation(0, -translationDistance);

    floatingViewController.view.transform = self.isPresenting ? floatingHiddenTransform : CGAffineTransformIdentity;
    self.backgroundSnapshot.transform = self.isPresenting ? CGAffineTransformIdentity : backgroundHiddenTransform;

    self.tabBarSnapshot.transform = self.isPresenting ? CGAffineTransformIdentity : tabBarHiddenTransform;
    self.tabBarSnapshot.alpha = self.isPresenting ? 1 : 0;

    id <LUNTabBarFloatingControllerAnimatedTransitioning> floatingAnimationController = nil;
    if ([floatingViewController conformsToProtocol:@protocol(LUNTabBarFloatingControllerAnimatedTransitioning)])
        floatingAnimationController = (id <LUNTabBarFloatingControllerAnimatedTransitioning>) floatingViewController;

    if ([floatingAnimationController respondsToSelector:@selector(floatingViewControllerStartedAnimatedTransition:)])
        [floatingAnimationController floatingViewControllerStartedAnimatedTransition:self.isPresenting];

    [UIView animateKeyframesWithDuration:duration
                                   delay:0
                                 options:0
                              animations:^{
                                  floatingViewController.view.transform = self.isPresenting ? CGAffineTransformIdentity : floatingHiddenTransform;
                                  self.backgroundSnapshot.transform = self.isPresenting ? backgroundHiddenTransform : CGAffineTransformIdentity;
                                  self.backgroundSnapshot.alpha = self.isPresenting ? self.alphaMultiplier : 1;

                                  self.tabBarSnapshot.transform = self.isPresenting ? tabBarHiddenTransform : CGAffineTransformIdentity;
                                  [UIView addKeyframeWithRelativeStartTime:self.isPresenting ? 0 : 0.4
                                                          relativeDuration:0.6
                                                                animations:^{
                                                                    self.tabBarSnapshot.alpha = self.isPresenting ? 0 : 1;
                                                                }];

                                  if ([floatingAnimationController respondsToSelector:@selector(keyframeAnimationForFloatingViewControllerAnimatedTransition:)])
                                      [floatingAnimationController keyframeAnimationForFloatingViewControllerAnimatedTransition:self.isPresenting]();
                              }
                              completion:^(BOOL finished) {
                                  BOOL completed = ![transitionContext transitionWasCancelled];
                                  [transitionContext completeTransition:completed];

                                  if ([floatingAnimationController respondsToSelector:@selector(floatingViewControllerFinishedAnimatedTransition:wasCompleted:)])
                                      [floatingAnimationController floatingViewControllerFinishedAnimatedTransition:self.isPresenting wasCompleted:completed];

                                  if (completed == !self.isPresenting) {
                                      [self.tabBarSnapshot removeFromSuperview];
                                      [self.backgroundSnapshot removeFromSuperview];
                                      [containerView addSubview:backgroundViewController.view];

                                      tabBarController.tabBar.alpha = 1;
                                  }

                                  floatingViewController.view.transform = CGAffineTransformIdentity;
                              }];
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (CGFloat)completionSpeed {
    return 0.999;
}

@end
