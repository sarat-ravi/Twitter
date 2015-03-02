//
//  TweetsViewController.h
//  Twitter
//
//  Created by Sarat Tallamraju on 2/21/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TweetsViewControllerDelegate <NSObject>

- (void) onHamburgerButtonPressed;

@end

@interface TweetsViewController : UIViewController

@property (strong, nonatomic) NSDictionary *timelineParams;
@property (nonatomic, strong) NSString *mode;

@end
