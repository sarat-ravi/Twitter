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
#import "TwitterClient.h"

@interface TweetDetailViewController () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UITextView *replyTextView;
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
    
    self.replyTextView.hidden = YES;
    self.replyTextView.delegate = self;
    self.replyTextView.text = [NSString stringWithFormat: @"@%@ ", self.tweet.user.screenName];
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSInteger numCharacters = textView.text.length + (text.length - range.length);
    
    if (numCharacters <= 140) {
        self.title = [NSString stringWithFormat: @"%ld characters", (long)numCharacters];
    } else {
        self.title = [NSString stringWithFormat: @"%ld characters", (long)140];
    }
    return numCharacters <= 140;
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"User is done replying to the tweet, but doing nothing");
}

- (void) onTextReply {
    NSLog(@"Reply button clicked");
    [[TwitterClient sharedInstance] replyToTweet: self.tweet withString: self.replyTextView.text];
    [self.replyTextView resignFirstResponder];
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)onReplyButton:(id)sender {
    NSLog(@"onReplyButton");
    self.replyTextView.hidden = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Reply"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onTextReply)];
}

- (IBAction)onRetweetButton:(id)sender {
    NSLog(@"onRetweetButton");
}

- (IBAction)onFavoriteButton:(id)sender {
    NSLog(@"onFavoriteButton");
}
@end
