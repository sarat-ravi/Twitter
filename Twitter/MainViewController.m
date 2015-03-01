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

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIViewController *menuViewController;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation MainViewController

- (id)initWithRootViewController: (UIViewController *)rootViewController
            andMenuViewController: (UIViewController *)menuViewController {
    self = [super init];
    
    if (self) {
        self.rootViewController = rootViewController;
        self.menuViewController = menuViewController;
        
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [self.contentView addSubview: self.menuViewController.view];
    self.rootViewController.view.frame = self.contentView.frame;
    self.menuViewController.view.frame = self.contentView.frame;
    [self.contentView addSubview: self.rootViewController.view];
    
    [self.menuViewController viewDidLoad];
    [self.rootViewController viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
