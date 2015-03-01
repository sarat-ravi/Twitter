//
//  User.h
//  Twitter
//
//  Created by Sarat Tallamraju on 2/21/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *profileBackgroundImageUrl;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, assign) NSInteger tweetCount;
@property (nonatomic, assign) NSInteger followingCount;
@property (nonatomic, assign) NSInteger followersCount;

- (id) initWithDictionary: (NSDictionary *) dictionary;

+ (User *) currentUser;
+ (void) setCurrentUser: (User *) user;

- (void) logout;

@end
