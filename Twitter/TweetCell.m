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
#import "TwitterClient.h"

@interface TweetCell()

- (IBAction)onReplyButton:(id)sender;
- (IBAction)onRetweetButton:(id)sender;
- (IBAction)onFavoriteButton:(id)sender;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) setTweet:(Tweet *)tweet {
    _tweet = tweet;
    User *user = tweet.user;
    [self.thumbnailImageView setImageWithURL: [NSURL URLWithString: user.profileImageUrl]];
    self.usernameLabel.text = user.name;
    self.timestampLabel.text = tweet.createdAt.shortTimeAgoSinceNow;
    self.tweetTextlabel.text = tweet.text;
    
    if (tweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet_on"] forState: UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet_default"] forState: UIControlStateNormal];
    }
    
    if (tweet.favorited) {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite_on"] forState: UIControlStateNormal];
    } else {
        [self.favoriteButton setImage:[UIImage imageNamed:@"favorite_default"] forState: UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)onReplyButton:(id)sender {
    // NSLog(@"reply button clicked on tweet cell");
    [self.delegate onReplyButton: self.replyButton forTweetCell: self];
}

- (IBAction)onRetweetButton:(id)sender {
    // NSLog(@"retweet button clicked on tweet cell");
    // [self.retweetButton setImage:[UIImage imageNamed:@"retweet_on"] forState: UIControlStateNormal];
    // [[TwitterClient sharedInstance] retweetTweet: self.tweet];
    // self.tweet.retweeted = YES;
    [self.delegate onRetweetButton: self.retweetButton forTweetCell: self];
}

- (IBAction)onFavoriteButton:(id)sender {
    // NSLog(@"favorite button clicked on tweet cell");
    // [self.favoriteButton setImage:[UIImage imageNamed:@"favorite_on"] forState: UIControlStateNormal];
    // [[TwitterClient sharedInstance] favoriteTweet: self.tweet];
    // self.tweet.favorited = YES;
    [self.delegate onFavoriteButton: self.favoriteButton forTweetCell: self];
}
@end
