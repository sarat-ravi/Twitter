//
//  TwitterClient.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/20/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterAPIKey = @"SgSRKLt7mvfX2n7YcvYOJoRfJ";
NSString * const kTwitterAPISecret = @"LEnfg55IFgs0uHppYD97Z3Q7Ig1O8PrtAmsNUSXCfPsgsIOLMm";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *client = nil;
    
    if (client == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^(void) {
            client = [[TwitterClient alloc] initWithBaseURL: [NSURL URLWithString: @"https://api.twitter.com"]
                                                consumerKey:kTwitterAPIKey
                                             consumerSecret:kTwitterAPISecret];
            
        });
    }
    
    return client;
}

- (void) openURL: (NSURL *) url {
    [[TwitterClient sharedInstance] fetchAccessTokenWithPath:@"oauth/access_token"
                                                      method:@"POST"
                                                requestToken: [BDBOAuth1Credential credentialWithQueryString: url.query]
                                                     success:^(BDBOAuth1Credential *accessToken) {
                                                         NSLog(@"Access token: %@", accessToken.token);
                                                         
                                                         [[TwitterClient sharedInstance].requestSerializer saveAccessToken: accessToken];
                                                         
                                                         [[TwitterClient sharedInstance] GET: @"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                             
                                                             User *user = [[User alloc] initWithDictionary: responseObject];
                                                             NSLog(@"successful User: %@", user);
                                                             self.loginCompletion(user, nil);
                                                             
                                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                             NSLog(@"Failure to GET");
                                                             self.loginCompletion(nil, error);
                                                         }];
                                                         
                                                     } failure: ^(NSError *error) {
                                                         NSLog(@"Failed to get access token!");
                                                         self.loginCompletion(nil, error);
                                                     }];
    
}

- (void) loginWithCompletion: (void (^)(User *user, NSError *error)) completion {
    self.loginCompletion = completion;
    
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
        self.loginCompletion(nil, error);
    }];
}


@end
