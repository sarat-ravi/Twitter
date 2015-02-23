//
//  TweetDetailViewController.h
//  Twitter
//
//  Created by Sarat Tallamraju on 2/22/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, assign) BOOL shouldActivateReplyUI;

@end
