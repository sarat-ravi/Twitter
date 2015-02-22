//
//  ComposeViewController.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/22/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "ComposeViewController.h"
#import "User.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UITextView *composeTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *currentUser = [User currentUser];
    [self.thumbnailImageView setImageWithURL: [NSURL URLWithString: currentUser.profileImageUrl]];
    self.usernameLabel.text = currentUser.name;
    
    self.composeTextView.delegate = self;
    self.composeTextView.text = @"";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Cancel"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onCancelButton)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"Tweet"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(onTweetButton)];
}

- (void) onCancelButton {
    NSLog(@"onCancelButton");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onTweetButton {
    NSLog(@"onTweetButton");
    [[TwitterClient sharedInstance] tweetWithString: self.composeTextView.text];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    NSLog(@"User is done composing the tweet");
}

@end
