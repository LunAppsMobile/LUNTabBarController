//
// Created by Victor Sharavara on 2/11/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LUNTabBarController : UITabBarController <UITabBarControllerDelegate>

/**
 @brief Specifies which tab should use animated transition
 */
@property (nonatomic) IBInspectable NSInteger floatingTabIndex;

/**
 @brief Specifies floating tab's content height.
 
 @brief This value determines initial translation by y of the floating tab's content.
 
 @brief You probably want this value to be greater or equal to the height of non-transparent content, otherwise you'll experience immediate appearing of that content on screen
 */
@property (nonatomic) IBInspectable CGFloat floatingContentHeight;

/**
 @brief Specifies duration in seconds of the animated transition
 */
@property (nonatomic) IBInspectable CGFloat transitionDuration;

/**
 @brief Specifies scale multiplier to be applied to the background view
 */
@property (nonatomic) IBInspectable CGFloat transitionScaleMultiplier;

/**
 @brief Specifies alpha multiplier to be applied to the background view
 */
@property (nonatomic) IBInspectable CGFloat transitionAlphaMultiplier;

/**
 @brief Hides floating tab if it's selected and returns to previous tab
 */
- (void)hideFloatingTab;

@end