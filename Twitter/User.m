//
//  User.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/21/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "User.h"

@implementation User

-(id) initWithDictionary: (NSDictionary *) dictionary {
    self = [super init];
    
    if (self) {
        
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
        
    }
    
    return self;
}

@end
