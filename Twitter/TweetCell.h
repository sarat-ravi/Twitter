//
//  TweetCell.h
//  Twitter
//
//  Created by Sarat Tallamraju on 2/21/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;

@protocol TweetCellDelegate <NSObject>

- (void) onReplyButton: (UIButton *)replyButton forTweetCell: (TweetCell *) tweetCell;
- (void) onRetweetButton: (UIButton *)retweetButton forTweetCell: (TweetCell *) tweetCell;
- (void) onFavoriteButton: (UIButton *)favoriteButton forTweetCell: (TweetCell *) tweetCell;

@end

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) Tweet *tweet;

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timestampLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextlabel;
@property (strong, nonatomic) IBOutlet UIButton *replyButton;
@property (strong, nonatomic) IBOutlet UIButton *retweetButton;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;

@property (weak, nonatomic) id<TweetCellDelegate> delegate;

- (void) setTweet: (Tweet *) tweet;

@end
