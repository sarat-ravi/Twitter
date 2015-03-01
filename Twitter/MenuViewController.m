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
    
    self.menuItems = @[@"Sign Out"];
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
    
    if (indexPath.row == 0) {
        [self onSignOut];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onSignOut {
    NSLog(@"Sign out clicked");
    [[User currentUser] logout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
