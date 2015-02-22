//
//  LoginViewController.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/20/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()
- (IBAction)onLogin:(id)sender;

@end

@implementation LoginViewController

- (IBAction)onLogin:(id)sender {
    NSLog(@"onLogin called");
    
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
    
    [[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token"
                                                       method: @"GET"
                                                  callbackURL: [NSURL URLWithString: @"cptwitterdemo://oauth"]
                                                        scope:nil
    success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Request token: %@", requestToken.token);
        
        NSString *authUrlString = [NSString stringWithFormat: @"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        NSURL *authUrl = [NSURL URLWithString: authUrlString];
        
        [[UIApplication sharedApplication] openURL: authUrl];
        
    } failure: ^(NSError *error) {
        NSLog(@"Failed to get a requst token");
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
