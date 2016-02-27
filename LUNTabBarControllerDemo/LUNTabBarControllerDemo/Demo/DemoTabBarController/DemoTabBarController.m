//
// Created by Victor Sharavara on 2/24/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import "DemoTabBarController.h"
#import "DemoFadeAnimationController.h"

@interface DemoTabBarController ()

@property (nonatomic, strong) DemoFadeAnimationController *fadeAnimationController;

@end

@implementation DemoTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.shadowImage = [UIImage new];

    for (UITabBarItem *tabBarItem in self.tabBar.items) {
        tabBarItem.image = [tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem.selectedImage = [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }

    self.fadeAnimationController = [[DemoFadeAnimationController alloc] init];
}

- (CGFloat)floatingContentHeight {
    return 500.0f / 568.0f * self.view.bounds.size.height;
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    id <UIViewControllerAnimatedTransitioning> animationController = [super tabBarController:tabBarController animationControllerForTransitionFromViewController:fromVC toViewController:toVC];
    if (!animationController) {
        animationController = self.fadeAnimationController;
        self.fadeAnimationController.transitionDuration = self.transitionDuration;
    }
    return animationController;
}

@end