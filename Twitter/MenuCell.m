//
//  MenuCell.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/28/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "MenuCell.h"

@interface MenuCell()
@property (strong, nonatomic) IBOutlet UILabel *menuTitleLabel;


@end

@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void) setMenuTitle:(NSString *)menuTitle {
    _menuTitle = menuTitle;
    self.menuTitleLabel.text = menuTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
