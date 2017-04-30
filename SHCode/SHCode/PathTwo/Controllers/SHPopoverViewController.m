//
//  SHPopoverViewController.m
//  SHCode
//
//  Created by ios on 17/4/10.
//  Copyright © 2017年 ios. All rights reserved.
//

#import "SHPopoverViewController.h"

static NSString * const SHPopoverViewControllerID = @"SHPopoverViewControllerID";


@interface SHPopoverViewController ()

@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation SHPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SHPopoverViewControllerID];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHPopoverViewControllerID forIndexPath:indexPath];
    cell.textLabel.text = kFormat(@"第%ld行", indexPath.row);
    return cell;
}


@end
