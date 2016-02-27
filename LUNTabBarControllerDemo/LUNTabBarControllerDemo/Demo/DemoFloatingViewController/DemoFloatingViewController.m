//
// Created by Victor Sharavara on 2/15/16.
// Copyright (c) 2016 Lunapps. All rights reserved.
//

#import "DemoFloatingViewController.h"
#import "LUNTabBarController.h"

@interface DemoFloatingViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *buttonClose;

@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, strong) NSArray<UIImage *> *images;

@end

@implementation DemoFloatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @[
            @"Terms of use",
            @"Settings",
            @"Email us"
    ];

    self.images = @[
            [UIImage imageNamed:@"iconTermsOfUse"],
            [UIImage imageNamed:@"iconSettings"],
            [UIImage imageNamed:@"iconEmailUs"]
    ];
}

- (IBAction)closeClicked:(id)sender {
    LUNTabBarController *tabBarController = (LUNTabBarController *) self.tabBarController;
    [tabBarController hideFloatingTab];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell"];
    cell.textLabel.text = self.titles[(NSUInteger) indexPath.row];
    cell.imageView.image = self.images[(NSUInteger) indexPath.row];
    return cell;
}

#pragma mark - LUNTabBarFloatingControllerAnimatedTransitioning

- (void)floatingViewControllerStartedAnimatedTransition:(BOOL)isPresenting {
    CGFloat angle = (CGFloat) (isPresenting ? -M_PI_2 : M_PI_2);
    self.buttonClose.transform = CGAffineTransformMakeRotation(angle);
    self.buttonClose.alpha = isPresenting ? 0 : 1;
}

- (void (^)(void))keyframeAnimationForFloatingViewControllerAnimatedTransition:(BOOL)isPresenting {
    return ^{
        UIColor *backgroundColor = isPresenting ? [[UIColor whiteColor] colorWithAlphaComponent:0.95] : [UIColor whiteColor];
        self.contentView.backgroundColor = backgroundColor;

        [UIView addKeyframeWithRelativeStartTime:isPresenting ? 0.8 : 0
                                relativeDuration:0.2
                                      animations:^{
                                          self.buttonClose.transform = CGAffineTransformIdentity;
                                          self.buttonClose.alpha = isPresenting ? 1 : 0;
                                      }];
    };
}

- (void)floatingViewControllerFinishedAnimatedTransition:(BOOL)isPresenting wasCompleted:(BOOL)wasCompleted {

}

@end