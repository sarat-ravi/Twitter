//
//  ProfileViewController.m
//  Twitter
//
//  Created by Sarat Tallamraju on 3/1/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "ProfileViewController.h"
#import "TweetsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *coverPhotoImageView;
@property (strong, nonatomic) IBOutlet UIImageView *profileThumbnail;
@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet UILabel *profileTag;
@property (strong, nonatomic) IBOutlet UILabel *numTweetsLabel;
@property (strong, nonatomic) IBOutlet UILabel *numFollowingLabel;
@property (strong, nonatomic) IBOutlet UILabel *numFollowersLabel;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) TweetsViewController *tweetsVC;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.profileName.text = self.user.name;
    self.profileTag.text = [NSString stringWithFormat: @"@%@", self.user.screenName];
    self.numTweetsLabel.text = [self formatLargeInteger: self.user.tweetCount];
    self.numFollowersLabel.text = [self formatLargeInteger: self.user.followersCount];
    self.numFollowingLabel.text = [self formatLargeInteger: self.user.followingCount];
    
    [self.coverPhotoImageView setImageWithURL: [NSURL URLWithString: self.user.profileBackgroundImageUrl]];
    [self.profileThumbnail setImageWithURL: [NSURL URLWithString: self.user.profileImageUrl]];
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:self.user.screenName forKey:@"screen_name"];
    
    self.tweetsVC = [[TweetsViewController alloc] init];
    self.tweetsVC.mode = @"Profile";
    self.tweetsVC.timelineParams = params;
    [self.contentView addSubview: self.tweetsVC.view];
    // self.tweetsVC.view.frame = self.contentView.frame;
    // [self.tweetsVC viewDidLoad];
}

- (NSString *)formatLargeInteger: (NSInteger) integer {
    return [NSString stringWithFormat: @"%ld", (long)integer];
}

@end
