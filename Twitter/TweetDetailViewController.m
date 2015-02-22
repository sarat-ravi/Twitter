//
//  TweetDetailViewController.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/22/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "User.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TweetDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *timestampTextLabel;

- (IBAction)onReplyButton:(id)sender;
- (IBAction)onRetweetButton:(id)sender;
- (IBAction)onFavoriteButton:(id)sender;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Tweet";
    
    User *user = self.tweet.user;
    [self.thumbnailImageView setImageWithURL: [NSURL URLWithString: user.profileImageUrl]];
    self.usernameTextLabel.text = user.name;
    self.tweetTextLabel.text = self.tweet.text;
    // self.timestampTextLabel.text = self.tweet.createdAt;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm a"];
    NSString *dateString = [format stringFromDate: self.tweet.createdAt];
    self.timestampTextLabel.text = dateString;
}

- (IBAction)onReplyButton:(id)sender {
    NSLog(@"onReplyButton");
}

- (IBAction)onRetweetButton:(id)sender {
    NSLog(@"onRetweetButton");
}

- (IBAction)onFavoriteButton:(id)sender {
    NSLog(@"onFavoriteButton");
}
@end
