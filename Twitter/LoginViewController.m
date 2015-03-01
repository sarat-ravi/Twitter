//
//  LoginViewController.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/20/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "MenuViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()
- (IBAction)onLogin:(id)sender;

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    NSLog(@"onLogin called");
    
    [[TwitterClient sharedInstance] loginWithCompletion: ^(User *user, NSError *error) {
        
        if (user != nil) {
            // yay!
            NSLog(@"Welcome user: %@", user.name);
            
            // TweetsViewController *vc = [[TweetsViewController alloc] init];
            // UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
            
            TweetsViewController *tweetsVC = [[TweetsViewController alloc] init];
            MenuViewController *menuVC = [[MenuViewController alloc] init];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tweetsVC];
            
            UIViewController *mainVC = [[MainViewController alloc] initWithRootViewController: navigationController
                                                                    andMenuViewController:menuVC];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController: mainVC animated:NO completion:nil];
            });
            
        } else {
            NSLog(@"There was an error in the login process: %@", error);
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
