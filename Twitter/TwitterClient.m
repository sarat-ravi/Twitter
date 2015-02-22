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

@end
