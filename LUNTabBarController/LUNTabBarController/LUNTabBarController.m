//
// Created by Victor Sharavara on 2/11/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import "LUNTabBarController.h"
#import "LUNTabBarAnimationController.h"

@interface LUNTabBarController ()

@property (nonatomic, strong) LUNTabBarAnimationController *animationController;
@property (nonatomic, strong) UIPanGestureRecognizer *dismissRecognizer;

@property (nonatomic) UIViewController *previousViewController;

- (void)handleDismissGestureRecognizer;

@end

@implementation LUNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.animationController = [[LUNTabBarAnimationController alloc] init];
    self.dismissRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismissGestureRecognizer)];
    self.delegate = self;
}

- (void)hideFloatingTab {
    if (self.selectedIndex == self.floatingTabIndex)
        self.selectedViewController = self.previousViewController;
}

- (void)handleDismissGestureRecognizer {
    switch (self.dismissRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self hideFloatingTab];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat translation = [self.dismissRecognizer translationInView:self.dismissRecognizer.view.superview].y;
            CGFloat progress = translation / self.floatingContentHeight;
            progress = MAX(0, MIN(1, progress));

            [self.animationController updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat velocity = [self.dismissRecognizer velocityInView:self.dismissRecognizer.view.superview].y;

            if (velocity > 0)
                [self.animationController finishInteractiveTransition];
            else
                [self.animationController cancelInteractiveTransition];
            break;
        }
        case UIGestureRecognizerStateCancelled:
            [self.animationController cancelInteractiveTransition];
            break;
        default:
            break;
    }
}

#pragma mark - UITabBarControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC {
    NSInteger fromIndex = [self.viewControllers indexOfObject:fromVC];
    NSInteger toIndex = [self.viewControllers indexOfObject:toVC];

    if (fromIndex == self.floatingTabIndex || toIndex == self.floatingTabIndex) {
        self.animationController.isPresenting = toIndex == self.floatingTabIndex;
        self.animationController.transitionDuration = self.transitionDuration;
        self.animationController.floatingContentHeight = self.floatingContentHeight;
        self.animationController.scaleMultiplier = self.transitionScaleMultiplier;
        self.animationController.alphaMultiplier = self.transitionAlphaMultiplier;

        if (toIndex == self.floatingTabIndex) {
            self.previousViewController = fromVC;
            [toVC.view addGestureRecognizer:self.dismissRecognizer];
        }

        return self.animationController;
    } else
        return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                      interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
    BOOL isRecognizerActive = self.dismissRecognizer.state == UIGestureRecognizerStateBegan || self.dismissRecognizer.state == UIGestureRecognizerStateChanged;
    return isRecognizerActive ? self.animationController : nil;
}

@end