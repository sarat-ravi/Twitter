//
//  TwitterClient.h
//  Twitter
//
//  Created by Sarat Tallamraju on 2/20/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) openURL: (NSURL *) url;

- (void) tweetWithString: (NSString *) tweetText;
- (void) replyToTweet: (Tweet *)tweet withString: (NSString *) replyText;

- (void) loginWithCompletion: (void (^)(User *user, NSError *error)) completion;

- (void) homeTimelineWithParams: (NSDictionary *) params completion: (void (^)(NSArray *tweets, NSError *error)) completion;

@end
