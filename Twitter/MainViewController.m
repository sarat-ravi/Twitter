//
//  MainViewController.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/28/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "MainViewController.h"
#import "TweetsViewController.h"

@interface MainViewController () <TweetsViewControllerDelegate>
- (IBAction)onPanContentView:(UIPanGestureRecognizer *)sender;

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIViewController *menuViewController;
@property (strong, nonatomic) IBOutlet UIView *contentView;
// @property (strong, nonatomic) IBOutlet UIView *backgroundContentView;
@property (nonatomic, assign) BOOL hamburgerMenuOpened;
@property (nonatomic, assign) NSInteger slideOffset;

@property (nonatomic, assign) CGPoint rootCenter;
@property (nonatomic, assign) CGPoint originalRootCenter;

@end

@implementation MainViewController

- (id)initWithRootViewController: (UIViewController *)rootViewController
            andMenuViewController: (UIViewController *)menuViewController {
    self = [super init];
    
    if (self) {
        self.rootViewController = rootViewController;
        self.menuViewController = menuViewController;
        self.slideOffset = 200;
        
        [[NSNotificationCenter defaultCenter] addObserverForName: @"Hamburger" object:nil queue: [NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [self onHamburgerButtonPressed];
        }];
        // [self.view addSubview: menuViewController.view];
        // [self.view addSubview: rootViewController.view];
    }
    
    return self;
}

- (void)onHamburgerButtonPressed {
    NSLog(@"onHamburgerButtonPressed");
    if (self.hamburgerMenuOpened) {
        [self closeHamburgerMenu];
    } else {
        [self openHamburgerMenu];
    }
}

- (void) openHamburgerMenu {
    self.hamburgerMenuOpened = YES;
    [UIView animateWithDuration: 1 delay: 0.1 usingSpringWithDamping: 0.6 initialSpringVelocity:0.9 options:0 animations:^{
        // Animation
        CGPoint center = self.rootViewController.view.center;
        self.rootViewController.view.center = CGPointMake(self.rootCenter.x + self.slideOffset, self.rootCenter.y);
    } completion:^(BOOL finished) {
        // Completion
    }];
}

- (void) closeHamburgerMenu {
    self.hamburgerMenuOpened = NO;
    [UIView animateWithDuration: 1 delay: 0.1 usingSpringWithDamping: 0.6 initialSpringVelocity:0.9 options:0 animations:^{
        // Animation
        CGPoint center = self.rootViewController.view.center;
        self.rootViewController.view.center = CGPointMake(self.rootCenter.x, self.rootCenter.y);
    } completion:^(BOOL finished) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootCenter = self.rootViewController.view.center;
    [self.contentView addSubview: self.menuViewController.view];
    self.rootViewController.view.frame = self.contentView.frame;
    self.menuViewController.view.frame = self.contentView.frame;
    [self.contentView addSubview: self.rootViewController.view];
    
    [self.menuViewController viewDidLoad];
    [self.rootViewController viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onPanContentView:(UIPanGestureRecognizer *)sender {
    CGPoint delta = [sender translationInView: self.view];
    // CGFloat displacement = MIN(delta.x, self.slideOffset);
    CGFloat displacement = delta.x;
    // displacement = MAX(0, displacement);
    
    if ([sender state] == UIGestureRecognizerStateBegan) {
        self.originalRootCenter = self.rootViewController.view.center;
    } else if ([sender state] == UIGestureRecognizerStateChanged) {
        self.rootViewController.view.center = CGPointMake(self.originalRootCenter.x + displacement, self.rootCenter.y);
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        CGPoint center = self.rootViewController.view.center;
        CGFloat absoluteDisplacement = center.x - self.rootCenter.x;
        if (absoluteDisplacement >= self.slideOffset / 2.0) {
            [self openHamburgerMenu];
        } else {
            [self closeHamburgerMenu];
        }
    }
    
}

@end
