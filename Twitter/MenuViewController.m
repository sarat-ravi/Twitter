//
//  MenuViewController.m
//  Twitter
//
//  Created by Sarat Tallamraju on 2/28/15.
//  Copyright (c) 2015 Sarat Tallamraju. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCell.h"
#import "User.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    UINib *cellNib = [UINib nibWithNibName: @"MenuCell" bundle:nil];
    [self.menuTableView registerNib:cellNib forCellReuseIdentifier: @"MenuCell"];
    self.menuTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.menuItems = @[@"Timeline", @"Mentions", @"Profile", @"Sign Out"];
    [self.menuTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier: @"MenuCell" forIndexPath:indexPath];
    cell.menuTitle = self.menuItems[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row %ld in section %ld", (long)indexPath.row, (long)indexPath.section);
    [self.menuTableView deselectRowAtIndexPath: indexPath animated: YES];
    
    switch (indexPath.row) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName: @"Timeline" object: nil];
            break;
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName: @"Mentions" object: nil];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName: @"Profile" object: nil];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] postNotificationName: @"Sign Out" object: nil];
            break;
        default:
            break;
    }
    
}

@end
