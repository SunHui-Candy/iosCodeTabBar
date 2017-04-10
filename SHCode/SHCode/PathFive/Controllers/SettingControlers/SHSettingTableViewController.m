//
//  SHSettingTableViewController.m
//  SHCode
//
//  Created by ios on 17/4/9.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHSettingTableViewController.h"

@interface SHSettingTableViewController ()

@end

@implementation SHSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = @"清除缓存";
    
    return cell;
}

@end
