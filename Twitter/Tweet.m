//
//  Tweet.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/21/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

+ (NSArray *) tweetsWithArray: (NSArray *) array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary: dictionary];
        [tweets addObject: tweet];
    }
    
    return tweets;
}

- (id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    
    if (self) {
        self.user = [[User alloc] initWithDictionary: dictionary[@"user"]];
        
        self.text = dictionary[@"text"];
        self.status_id = dictionary[@"id"];
        
        // NSLog(@"%@", dictionary);
        
        // NSLog(@"!!!!!!!!!!!!!!!!!! Parsed status ID: %@", self.status_id);
        
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        
        self.createdAt = [formatter dateFromString: createdAtString];
    }
    
    return self;
}

@end
