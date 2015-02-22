//
//  TweetCell.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/21/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "NSDate+DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) setTweet: (Tweet *) tweet {
    User *user = tweet.user;
    [self.thumbnailImageView setImageWithURL: [NSURL URLWithString: user.profileImageUrl]];
    self.usernameLabel.text = user.name;
    self.timestampLabel.text = tweet.createdAt.shortTimeAgoSinceNow;
    self.tweetTextlabel.text = tweet.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
