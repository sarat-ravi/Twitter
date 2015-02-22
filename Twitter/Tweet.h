//
//  Tweet.h
//  Twitter
//
//  Created by Sarat Tallamraju on 2/21/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *status_id;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, assign) BOOL retweeted;

- (id) initWithDictionary: (NSDictionary *) dictionary;

+ (NSArray *) tweetsWithArray: (NSArray *) array;

@end
