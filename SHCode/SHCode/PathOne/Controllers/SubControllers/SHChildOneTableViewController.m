//
//  SHChildOneTableViewController.m
//  SHCode
//
//  Created by ios on 17/4/4.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHChildOneTableViewController.h"

@interface SHChildOneTableViewController ()

@end

@implementation SHChildOneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = kSHRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(SHTopHeightTitle + SHNavMaxY, 0, SHTabBarH, 0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    cell.textLabel.text = kFormat(@"%@-%ld", NSStringFromClass([self class]),(long)indexPath.row);
    
    return cell;
}



@end
