//
//  TwitterClient.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/20/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

NSString * const kTwitterAPIKey = @"nNMcKrWBu0FRBNt1XsUin0Iws";
NSString * const kTwitterAPISecret = @"98BVZ1QG4fSWqXrpAnmWMSDDP7IlhGZq9ReAZuuRY0teujbFV7";

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

- (void) favoriteTweet: (Tweet *)tweet {
    NSString *url = [NSString stringWithFormat: @"1.1/favorites/create.json?id=%@", tweet.status_id];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: tweet.status_id forKey: @"id"];
    
    [[TwitterClient sharedInstance] POST: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully favorited");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure to favorite: %@", error);
    }];
}

- (void) retweetTweet: (Tweet *)tweet {
    NSString *url = [NSString stringWithFormat: @"1.1/statuses/retweet/%@.json", tweet.status_id];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: tweet.status_id forKey: @"id"];
    
    [[TwitterClient sharedInstance] POST: url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully retweeted");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure to retweet: %@", error);
    }];
}

- (void) replyToTweet: (Tweet *)tweet withString: (NSString *) replyText {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: replyText forKey: @"status"];
    [params setObject: tweet.status_id forKey: @"in_reply_to_status_id"];
    
    [[TwitterClient sharedInstance] POST: @"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully replied to tweet");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure to Reply Tweet: %@", error);
    }];
}

- (void) tweetWithString: (NSString *) tweetText {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: tweetText forKey: @"status"];
    [[TwitterClient sharedInstance] POST: @"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully tweeted");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure to Tweet: %@", error);
    }];
}

- (void) homeTimelineWithParams: (NSDictionary *) params completion: (void (^)(NSArray *tweets, NSError *error)) completion {
    [[TwitterClient sharedInstance] GET: @"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *tweets = [Tweet tweetsWithArray: responseObject];
        completion(tweets, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure to GET");
        completion(nil, error);
    }];
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
                                                             [User setCurrentUser: user];
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
