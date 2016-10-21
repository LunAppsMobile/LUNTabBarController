# LUNTabBarController

[![Crafted in LunApps](https://lunapps.com/img/crafted-in-lunapps.png)](https://lunapps.com/)

Please check this [article](https://lunapps.com/blog/how-we-created-animated-tab-bar-for-mobile-apps/) on our blog.

Purpose
-------

LUNTabBarController is UITabBarController subclass designed to add cool floating from the bottom animation with scale effect that adds feeling of 3D to one of your tabs. With LUNTabBarController you can achieve visual effect of transforming your tab bar into your view controller like in example below.

![Gif animation](https://lunapps.com/blog/wp-content/uploads/2016/02/LUNTabBarController_animation.gif)

Supported OS & SDK Versions
---------------------------

* Supported build target - iOS 8.0
	
ARC Compatibility
-----------------

LUNTabBarController requires ARC. In order to use LUNTabBarController in a non-ARC project you need to add the -fobjc-arc compiler flag to the LUNTabBarController.m and LUNTabBarAnimationController.m files.

Installation
------------

To use the LUNTabBarController in your app, just drag the LUNTabBarController folder into your project.

Or you can use CocoaPods 

```ruby
pod 'LUNTabBarController', '~> 1.0'
```

Usage
-----

To make use of this project just change the class of your application tab bar controller to LUNTabBarController and set the following properties in the interface builder:

    @property (nonatomic) IBInspectable NSInteger floatingTabIndex;

Specifies which tab should use animated transition.

	@property (nonatomic) IBInspectable CGFloat floatingContentHeight;

Specifies floating tab's content height. This value determines initial translation by y of the floating tab's content. You probably want this value to be greater or equal to the height of non-transparent content, otherwise you'll experience immediate appearing of that content on screen.

	@property (nonatomic) IBInspectable CGFloat transitionDuration;

Specifies duration in seconds of the animated transition.

	@property (nonatomic) IBInspectable CGFloat transitionScaleMultiplier;

Specifies scale multiplier to be applied to the background view.

	@property (nonatomic) IBInspectable CGFloat transitionAlphaMultiplier;

Specifies alpha multiplier to be applied to the background view.

Notes
-----

If you have transitionScaleMultiplier less than 1.0 then you'll see background around the scaled view. To change color of this background just set tab bar controller's view color to whatever you want. You can do this with runtime attribute or programmatically.

If content height isn't a constant (for example depends on screen height) you  should set floatingContentHeight property programmatically depending on your logic. The easiest way to do this is probably subclass LUNTabBarController and override getter of this property. Alternatively you can just set property from anywhere outside of the class.

While designing your floating tab's interface you need to know these:

1. Your view controller would be displayed full screen as it is supposed by tab bar controller, so you need to place your content at the bottom.

2. Bottom layout guide will include the height of tab bar even though tab bar won't be visible, so you probably want to specify bottom space to superview but not to bottom layout guide.

3. You want your view controller's view edges to be extended under tab bar otherwise there would be no your content in place where tab bar usually appears to be. To achieve this just make sure you have Extend Edges Under Bottom Bars enabled in your view controller. If your tab bar is opaque make sure Extend Edges Under Opaque Bars is also enabled.

To close floating tab programmatically you should call the following method

    - (void)hideFloatingTab;

Handling events and providing additional animation
--------------------------------------------------

You can get information about animated transition and provide additional animations by implementing LUNTabBarFloatingControllerAnimatedTransitioning protocol in your floating tab's view controller. This protocol includes next methods:

    - (void)floatingViewControllerStartedAnimatedTransition:(BOOL)isPresenting;

Notifies when animated transition starts.

    - (void (^)(void))keyframeAnimationForFloatingViewControllerAnimatedTransition:(BOOL)isPresenting;

This method is used to provide additional custom animation alongside the transition.

    - (void)floatingViewControllerFinishedAnimatedTransition:(BOOL)isPresenting wasCompleted:(BOOL)wasCompleted;
    
Notifies when animated transition finishes.

License
-------

Usage is provided under the [MIT License](http://opensource.org/licenses/MIT)
